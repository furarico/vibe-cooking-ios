//
//  VibeCookingListPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Observation

@Observable
final class VibeCookingListPresenter<Environment: EnvironmentProtocol>: PresenterProtocol {
    struct State: Equatable {
        var recipes: DataState<[Components.Schemas.Recipe], DomainError> = .idle
    }

    enum Action: Equatable {
        case onAppear
        case onDelete(id: String)
    }

    var state = State()

    private let vibeCookingListService = VibeCookingListService<Environment>()

    func dispatch(_ action: Action) {
        Task {
            await dispatch(action)
        }
    }

    func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()

        case .onDelete(let id):
            await onDelete(id: id)
        }
    }
}

private extension VibeCookingListPresenter {
    func onAppear() async {
        state.recipes = .loading
        do {
            let recipes = try await vibeCookingListService.getRecipes()
            state.recipes = .success(recipes)
        } catch {
            state.recipes = .failure(.init(error))
        }
    }

    func onDelete(id: String) async {
        do {
            try await vibeCookingListService.removeRecipe(id: id)
            guard case .success(let recipes) = state.recipes else { return }
            let updatedRecipes = recipes.filter { $0.id != id }
            state.recipes = .success(updatedRecipes)
        } catch {
            Logger.error("Failed to delete recipe: \(error.localizedDescription)")
        }
    }
}
