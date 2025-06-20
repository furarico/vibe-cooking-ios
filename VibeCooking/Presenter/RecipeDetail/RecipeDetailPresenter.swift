//
//  RecipeDetailPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Observation

@Observable
final class RecipeDetailPresenter<Environment: EnvironmentProtocol>: PresenterProtocol {
    struct State: Equatable {
        var recipe: DataState<Components.Schemas.Recipe, DomainError> = .idle
        var isCookingScreenPresented: Bool = false
        var isOnVibeCookingList: DataState<Bool, DomainError> = .idle
    }

    enum Action {
        case onAppear
        case onVibeCookingButtonTapped
        case onVibeCookingListButtonTapped
    }

    var state = State()

    private let recipeService = RecipeService<Environment>()
    private let vibeCookingListService = VibeCookingListService<Environment>()

    private let recipeID: String

    init(recipeID: String) {
        self.recipeID = recipeID
    }

    func dispatch(_ action: Action) {
        Task {
            await dispatch(action)
        }
    }

    func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()

        case .onVibeCookingButtonTapped:
            await onVibeCookingButtonTapped()

        case .onVibeCookingListButtonTapped:
            await onVibeCookingListButtonTapped()
        }
    }
}

private extension RecipeDetailPresenter {
    func onAppear() async {
        state.recipe = .loading
        state.isOnVibeCookingList = .loading
        await withTaskGroup { [weak self] group in
            group.addTask {
                do {
                    guard
                        let recipeID = self?.recipeID,
                        let recipe = try await self?.recipeService.getRecipe(id: recipeID)
                    else { return }
                    await MainActor.run {
                        self?.state.recipe = .success(recipe)
                    }
                } catch {
                    await MainActor.run {
                        self?.state.recipe = .failure(.init(error))
                    }
                }
            }
            group.addTask {
                do {
                    guard
                        let recipeID = self?.recipeID,
                        let recipesOnVibeCookingList = try await self?.vibeCookingListService.getRecipes()
                    else { return }
                    let isOnVibeCookingList = recipesOnVibeCookingList.contains { $0.id == recipeID }
                    await MainActor.run {
                        self?.state.isOnVibeCookingList = .success(isOnVibeCookingList)
                    }
                } catch {
                    await MainActor.run {
                        self?.state.isOnVibeCookingList = .failure(.init(error))
                    }
                }
            }
            await group.waitForAll()
        }
    }

    func onVibeCookingButtonTapped() async {
        state.isCookingScreenPresented = true
    }

    func onVibeCookingListButtonTapped() async {
        do {
            if case let .success(isOnVibeCookingList) = state.isOnVibeCookingList {
                state.isOnVibeCookingList = .loading
                if isOnVibeCookingList {
                    try await vibeCookingListService.removeRecipe(id: recipeID)
                    state.isOnVibeCookingList = .success(false)
                } else {
                    try await vibeCookingListService.addRecipe(id: recipeID)
                    state.isOnVibeCookingList = .success(true)
                }
            }
        } catch {
            Logger.error(error)
            state.isOnVibeCookingList = .failure(.init(error))
        }
    }
}
