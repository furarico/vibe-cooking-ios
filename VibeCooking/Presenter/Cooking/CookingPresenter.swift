//
//  CookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Observation

@Observable
final class CookingPresenter<Environment: EnvironmentProtocol>: PresenterProtocol {
    struct State: Equatable {
        var recipe: Components.Schemas.Recipe
        var currentInstructionStep: Int = 1
        var currentInstructionID: Components.Schemas.Instruction.ID? {
            get {
                guard
                    let instructions = recipe.instructions,
                    let instruction = instructions.first(where: { instruction in
                        instruction.step == currentInstructionStep
                    })
                else {
                    return nil
                }
                return instruction.id
            }
            set {
                guard
                    let newValue,
                    let instructions = recipe.instructions,
                    let instruction = instructions.first(where: { instruction in
                        instruction.id == newValue
                    })
                else {
                    currentInstructionStep = 1
                    return
                }
                currentInstructionStep = instruction.step
            }
        }
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
