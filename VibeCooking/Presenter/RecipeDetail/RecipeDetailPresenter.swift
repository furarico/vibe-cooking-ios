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
    }

    enum Action {
        case onAppear
    }

    var state = State()

    private let recipeService = RecipeService<Environment>()

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
        }
    }
}

private extension RecipeDetailPresenter {
    func onAppear() async {
        do {
            let recipe = try await recipeService.getRecipe(id: recipeID)
            state.recipe = .success(recipe)
        } catch {
            state.recipe = .failure(.init(error))
        }
    }
}
