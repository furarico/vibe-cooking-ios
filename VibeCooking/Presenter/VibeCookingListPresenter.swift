//
//  VibeCookingListPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Foundation
import Observation

@Observable
final class VibeCookingListPresenter: PresenterProtocol {
    struct State: Equatable {
        var recipes: DataState<[Recipe], DomainError> = .idle
    }

    enum Action: Equatable {
        case onAppear
        case onDelete(offsets: IndexSet)
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
        case .onAppear:
            await onAppear()

        case .onDelete(let offsets):
            await onDelete(offsets: offsets)
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
            Logger.error(error)
            state.recipes = .failure(.init(error))
        }
    }

    func onDelete(offsets: IndexSet) async {
        do {
            guard var recipes = state.recipes.value else {
                return
            }
            state.recipes = .reloading(recipes)
            for index in offsets {
                let id = recipes[index].id
                try await vibeCookingListService.removeRecipe(id: id)
            }
            recipes.remove(atOffsets: offsets)
            state.recipes = .success(recipes)
        } catch {
            Logger.error(error)
            guard let recipes = state.recipes.value else {
                state.recipes = .failure(.init(error))
                return
            }
            state.recipes = .success(recipes)
        }
    }
}
