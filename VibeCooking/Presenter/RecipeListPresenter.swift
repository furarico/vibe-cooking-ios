//
//  RecipeListPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Observation

@Observable
final class RecipeListPresenter: PresenterProtocol {
    struct State: Equatable {
        var recipes: DataState<[Components.Schemas.Recipe], DomainError> = .idle
    }

    enum Action {
        case onAppear
    }

    var state = State()

    private let recipeService = RecipeService()

    func dispatch(_ action: Action) {
        Task {
            await dispatch(action)
        }
    }

    func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        }
    }
}

private extension RecipeListPresenter {
    func onAppear() async {
        state.recipes = .loading
        do {
            let recipes = try await recipeService.getRecipes()
            state.recipes = .success(recipes)
        } catch {
            state.recipes = .failure(DomainError(error))
        }
    }
}
