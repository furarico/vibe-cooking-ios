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
        var currentInstructionStep: Int = 1 {
            didSet {
                if currentInstructionStep < 1 {
                    currentInstructionStep = 1
                } else if currentInstructionStep > recipe.instructions.count {
                    currentInstructionStep = recipe.instructions.count
                } else {
                    currentInstructionID = recipe.instructions.first(where: { instruction in
                        instruction.step == currentInstructionStep
                    })?.id
                }
            }
        }
        var currentInstructionID: Components.Schemas.Instruction.ID? {
            get {
                guard
                    let instruction = recipe.instructions.first(where: { instruction in
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
                    let instruction = recipe.instructions.first(where: { instruction in
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
        case onDisappear
    }

    var state: State

    private let cookingService = CookingService<Environment>()

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

        case .onDisappear:
            await onDisappear()
        }
    }
}

private extension CookingPresenter {
    func onAppear() async {
        Task {
            for await voiceCommand in await cookingService.startListening() {
                switch voiceCommand {
                case .goBack:
                    if state.currentInstructionStep > 1 {
                        state.currentInstructionStep -= 1
                    }
                case .goForward:
                    if state.currentInstructionStep < state.recipe.instructions.count {
                        state.currentInstructionStep += 1
                    }
                case ._repeat:
                    break
                case .none:
                    break
                }
            }
        }
    }

    func onDisappear() async {
        await cookingService.stopListening()
    }
}
