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
        var transcript: String = ""
    }

    enum Action {
        case onAppear
        case onDisappear
    }

    var state: State

    private let speechRecognitionService = SpeechRecognitionService()

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
            for await result in await speechRecognitionService.startTranscribing() {
                state.transcript = result.text
            }
        }
    }

    func onDisappear() async {
        await speechRecognitionService.stopTranscribing()
    }
}
