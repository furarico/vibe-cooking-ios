//
//  CookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Observation

@Observable
final class CookingPresenter: PresenterProtocol {
    struct State: Equatable {
        var recipe: Components.Schemas.Recipe
    }

    enum Action {
        case onAppear
    }

    var state: State

    init(recipe: Components.Schemas.Recipe) {
        state = .init(recipe: recipe)
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

private extension CookingPresenter {
    func onAppear() async {
    }
}
