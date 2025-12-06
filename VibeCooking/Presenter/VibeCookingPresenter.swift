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
        var vibeRecipe: DataState<[Recipe], DomainError> = .idle
        var instructions: [Instruction]? {
            vibeRecipe.value?.flatMap { $0.instructions }.sorted { $0.step < $1.step }
        }
        var currentStep: Int? = 1
        var currentInstruction: Instruction? {
            get {
                instructions?.first { $0.step == currentStep }
            }
        }
        var isRecognizingVoice: Bool = false
        var cookingTimers: [CookingTimer] = []
    }

    enum Action: Equatable {
        case onAppear
        case onDisappear
        case onInstructionChanged
        case onStartTimerButtonTapped
        case onStopTimerButtonTapped
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

        case .onStartTimerButtonTapped:
            await onStartTimerButtonTapped()

        case .onStopTimerButtonTapped:
            await onStopTimerButtonTapped()
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

    func onStartTimerButtonTapped() async {
        await startTimer()
    }

    func onStopTimerButtonTapped() async {
        await stopTimer()
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
                if let instructionsCount = state.instructions?.count,
                   currentStep < instructionsCount {
                    state.currentStep = currentStep + 1
                }

            case .again:
                await playAudio()

            case .startTimer:
                await startTimer()

            case .stopTimer:
                await stopTimer()

            case .none:
                break
            }

            switch voiceCommand {
            case .goBack, .goForward, .again, .startTimer, .stopTimer:
                do {
                    try await cookingService.clearTranscriptions()
                } catch {
                    Logger.error(error)
                }

            default:
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

    func startTimer() async {
        guard
            let instruction = state.currentInstruction,
            let interval = instruction.timerDuration
        else {
            return
        }
        Logger.debug("Starting timer for instruction: \(instruction.id)")
        do {
            guard
                let alarmID = try await cookingService.startTimer(for: instruction)
            else {
                return
            }
            let now = Date()
            let duration = now..<now.addingTimeInterval(interval)
            let cookingTimer = CookingTimer(
                alarmID: alarmID,
                instructionID: instruction.id,
                duration: duration
            )
            state.cookingTimers.append(cookingTimer)
        } catch {
            Logger.error(error)
        }
        Logger.debug("Started timer for instruction: \(instruction.id)")
    }

    func stopTimer() async {
        guard
            let instruction = state.currentInstruction,
            let timer = state.cookingTimers.first(where: { $0.instructionID == instruction.id })
        else {
            return
        }
        Logger.debug("Stopping timer for instruction: \(instruction.id)")
        do {
            try await cookingService.stopTimer(of: timer.alarmID)
            state.cookingTimers.removeAll(where: { $0.instructionID == instruction.id })
        } catch {
            Logger.error(error)
        }
        Logger.debug("Stopped timer for instruction: \(instruction.id)")
    }
}
