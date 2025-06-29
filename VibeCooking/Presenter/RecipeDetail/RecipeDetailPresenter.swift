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
        var vibeCookingList: DataState<[Components.Schemas.Recipe.ID], DomainError> = .idle
        var isOnVibeCookingList: Bool? {
            get {
                guard case let .success(recipe) = recipe else { return nil }
                guard case let .success(vibeCookingList) = vibeCookingList else { return nil }
                return vibeCookingList.contains(recipe.id)
            }
        }
        var vibeRecipe: Components.Schemas.VibeRecipe? = nil
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
        state.vibeCookingList = .loading
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
                    guard let recipesOnVibeCookingList = try await self?.vibeCookingListService.getRecipes() else { return }
                    await MainActor.run {
                        self?.state.vibeCookingList = .success(recipesOnVibeCookingList.map(\.id))
                    }
                } catch {
                    await MainActor.run {
                        self?.state.vibeCookingList = .failure(.init(error))
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
            if state.isOnVibeCookingList ?? false {
                try await vibeCookingListService.removeRecipe(id: recipeID)
                state.vibeCookingList = .success(try await vibeCookingListService.getRecipes().map(\.id))
            } else if case let .success(vibeCookingList) = state.vibeCookingList,
                      vibeCookingList.count < 3 {
                try await vibeCookingListService.addRecipe(id: recipeID)
                state.vibeCookingList = .success(try await vibeCookingListService.getRecipes().map(\.id))
            }
        } catch {
            Logger.error(error)
            state.vibeCookingList = .failure(.init(error))
        }
    }
}
