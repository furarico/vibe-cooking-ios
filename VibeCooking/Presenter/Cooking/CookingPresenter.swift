//
//  CookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation
import Observation

@Observable
final class CookingPresenter<Environment: EnvironmentProtocol>: PresenterProtocol {
    struct State: Equatable {
        var recipe: Components.Schemas.Recipe
        var currentInstructionStep: Int {
            get {
                (recipe.instructions.firstIndex(where: {
                    $0.id == currentInstructionID
                }) ?? 0) + 1
            }
            set {
                guard newValue >= 1, newValue <= recipe.instructions.count else { return }
                currentInstructionID = recipe.instructions.first(where: {
                    $0.step == newValue
                })?.id
            }
        }
        var currentInstructionID: Components.Schemas.Instruction.ID? = nil
    }

    enum Action {
        case onAppear
        case onDisappear
        case onInstructionAppear(Components.Schemas.Instruction)
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

        case .onInstructionAppear(let instruction):
            await onInstructionAppear(instruction: instruction)
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

    func onInstructionAppear(instruction: Components.Schemas.Instruction) async {
        guard let url = URL(string: instruction.audioUrl ?? "") else {
            return
        }
        do {
            try await cookingService.playAudio(url: url)
        } catch {
            Logger.error(error)
        }
    }
}
