//
//  ContentPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Observation

@Observable
final class ContentPresenter: PresenterProtocol {
    struct State: Equatable {
        var isVibeCookingListPresented = false
        var isVibeCookingPresented = false
        var vibeCookingListRecipeIDs: [Components.Schemas.Recipe.ID] = []
    }

    enum Action: Equatable {
        case onVibeCookingListButtonTapped
        case onStartVibeCookingButtonTapped(recipeIDs: [String])
    }

    var state = State()

    private let vibeCookingListService = VibeCookingListService()

    func dispatch(_ action: Action) {
        Task {
            await dispatch(action)
        }
    }

    func dispatch(_ action: Action) async {
        switch action {
        case .onVibeCookingListButtonTapped:
            await onVibeCookingListButtonTapped()

        case .onStartVibeCookingButtonTapped(let recipeIDs):
            await onStartVibeCookingButtonTapped(recipeIDs: recipeIDs)
        }
    }
}

private extension ContentPresenter {
    func onVibeCookingListButtonTapped() async {
        state.isVibeCookingListPresented = true
    }

    func onStartVibeCookingButtonTapped(recipeIDs: [Components.Schemas.Recipe.ID]) async {
        do {
            try await vibeCookingListService.clearRecipes()
            state.isVibeCookingListPresented = false
            state.vibeCookingListRecipeIDs = recipeIDs
            state.isVibeCookingPresented = true
        } catch {
            Logger.error(error)
        }
    }
}
