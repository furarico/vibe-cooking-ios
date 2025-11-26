//
//  CookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import AVFoundation
import Foundation
import Observation
import SwiftUI

@Observable
final class CookingPresenter: PresenterProtocol {
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
        var isRecognizingVoice: Bool = false
    }

    enum Action {
        case onAppear
        case onDisappear
        case onInstructionChanged(Components.Schemas.Instruction)
    }

    var state: State

    private let cookingService = CookingService()

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

        case .onInstructionChanged(let instruction):
            await onInstructionChanged(instruction: instruction)
        }
    }
}

private extension CookingPresenter {
    func onAppear() async {
        UIApplication.shared.isIdleTimerDisabled = true
        guard let instruction = state.recipe.instructions.sorted(by: { $0.step < $1.step }).first else {
            return
        }
        await playAudio(of: instruction)
    }

    func onDisappear() async {
        UIApplication.shared.isIdleTimerDisabled = false
        await cookingService.stopAll()
    }

    func onInstructionChanged(instruction: Components.Schemas.Instruction) async {
        await playAudio(of: instruction)
    }
}

private extension CookingPresenter {
    func startSpeechRecognition() async {
        state.isRecognizingVoice = true
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

    func playAudio(of instruction: Components.Schemas.Instruction) async {
        state.isRecognizingVoice = false
        guard let url = URL(string: instruction.audioUrl ?? "") else {
            return
        }
        do {
            try await cookingService.playAudio(url: url) { [weak self] in
                Task {
                    await self?.startSpeechRecognition()
                }
            }
        } catch {
            Logger.error(error)
        }
    }
}
