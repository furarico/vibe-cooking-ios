//
//  CookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Observation
import SwiftUI

@Observable
final class CookingPresenter: PresenterProtocol {
    struct State: Equatable {
        var recipe: Recipe
        var currentStep: Int? = 1
        var currentInstruction: Instruction? {
            get {
                recipe.instructions.first { $0.step == currentStep }
            }
        }
        var isRecognizingVoice: Bool = false
        var cookingTimers: [CookingTimer] = []
    }

    enum Action {
        case onAppear
        case onDisappear
        case onInstructionChanged
        case onStartTimerButtonTapped
        case onStopTimerButtonTapped
    }

    var state: State

    private let cookingService = CookingService()

    init(recipe: Recipe) {
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

        case .onInstructionChanged:
            await onInstructionChanged()

        case .onStartTimerButtonTapped:
            await onStartTimerButtonTapped()

        case .onStopTimerButtonTapped:
            await onStopTimerButtonTapped()
        }
    }
}

private extension CookingPresenter {
    func onAppear() async {
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

private extension CookingPresenter {
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
                if currentStep < state.recipe.instructions.count {
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
            let alarmID = try await cookingService.startTimer(interval: interval)
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
