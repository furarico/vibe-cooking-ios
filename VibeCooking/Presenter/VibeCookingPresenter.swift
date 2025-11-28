//
//  VibeCookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Observation
import SwiftUI

@Observable
final class VibeCookingPresenter: PresenterProtocol {
    struct State: Equatable {
        var vibeRecipe: DataState<VibeRecipe, DomainError> = .idle
        var currentStep: Int? = 1
        var currentInstruction: Instruction? {
            get {
                vibeRecipe.value?.instructions.first { $0.step == currentStep }
            }
        }
        var currentRecipe: Recipe? {
            get {
                guard
                    let instructionID = currentInstruction?.id
                else {
                    return nil
                }
                return vibeRecipe.value?.recipes.first(where: { $0.instructions.map(\.id).contains(instructionID) })
            }
        }
        var isRecognizingVoice: Bool = false
    }

    enum Action: Equatable {
        case onAppear
        case onDisappear
        case onInstructionChanged
    }

    var state = State()

    private let recipeIDs: [String]

    private let cookingService = CookingService()
    private let recipeService = RecipeService()

    init(recipeIDs: [String]) {
        self.recipeIDs = recipeIDs
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

        case .onInstructionChanged:
            await onInstructionChanged()
        }
    }
}

private extension VibeCookingPresenter {
    func onAppear() async {
        if recipeIDs.count < 2 || recipeIDs.count > 3 {
            return
        }
        state.vibeRecipe = .loading
        do {
            let vibeRecipe = try await recipeService.getVibeRecipe(recipeIDs: recipeIDs)
            state.vibeRecipe = .success(vibeRecipe)
        } catch {
            Logger.error(error)
            state.vibeRecipe = .failure(.init(error))
            return
        }
        UIApplication.shared.isIdleTimerDisabled = true
        await playAudio()
    }

    func onDisappear() async {
        UIApplication.shared.isIdleTimerDisabled = false
        await cookingService.stopAll()
    }

    func onInstructionChanged() async {
        await playAudio()
    }
}

private extension VibeCookingPresenter {
    func startSpeechRecognition() async {
        state.isRecognizingVoice = true
        let currentStep = state.currentStep ?? 1
        for await voiceCommand in await cookingService.startListening() {
            switch voiceCommand {
            case .goBack:
                if currentStep > 1 {
                    state.currentStep = currentStep - 1
                }
            case .goForward:
                if let instructionsCount = state.vibeRecipe.value?.instructions.count,
                   currentStep < instructionsCount {
                    state.currentStep = currentStep + 1
                }
            case .again:
                await playAudio()
            case .startTimer:
                break
            case .stopTimer:
                break
            case .none:
                break
            }
        }
    }

    func playAudio() async {
        state.isRecognizingVoice = false
        guard let url = state.currentInstruction?.audioURL else {
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
