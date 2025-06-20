//
//  VibeCookingPresenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Observation
import SwiftUI

@Observable
final class VibeCookingPresenter<Environment: EnvironmentProtocol>: PresenterProtocol {
    struct State: Equatable {
        var vibeRecipe: DataState<Components.Schemas.VibeRecipe, DomainError> = .idle
        var recipes: DataState<[Components.Schemas.Recipe], DomainError> = .idle
        var instructions: DataState<[Components.Schemas.Instruction], DomainError> = .idle
        var currentInstructionStep: Int {
            get {
                guard case let .success(instructions) = instructions else {
                    return 1
                }
                return (instructions.firstIndex(where: {
                    $0.id == currentInstructionID
                }) ?? 0) + 1
            }
            set {
                guard case let .success(instructions) = instructions else {
                    return
                }
                guard newValue >= 1, newValue <= instructions.count else { return }
                currentInstructionID = instructions.first(where: {
                    $0.step == newValue
                })?.id
            }
        }
        var currentInstructionID: Components.Schemas.Instruction.ID? = nil
        var isRecognizingVoice: Bool = false
    }

    enum Action: Equatable {
        case onAppear
        case onDisappear
        case onInstructionChanged(instruction: Components.Schemas.Instruction)
    }

    var state = State()

    private let recipeIDs: [String]

    init(recipeIDs: [String]) {
        self.recipeIDs = recipeIDs
    }

    private let cookingService = CookingService<Environment>()
    private let recipeService = RecipeService<Environment>()

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

private extension VibeCookingPresenter {
    func onAppear() async {
        UIApplication.shared.isIdleTimerDisabled = true
        if recipeIDs.count > 3 {
            return
        }
        state.vibeRecipe = .loading
        state.recipes = .loading
        do {
            let vibeRecipe = try await recipeService.getVibeRecipe(recipeIDs: recipeIDs)
            state.vibeRecipe = .success(vibeRecipe)
        } catch {
            Logger.error(error)
            state.vibeRecipe = .failure(.init(error))
            return
        }
        do {
            let recipes = try await withThrowingTaskGroup(returning: [Components.Schemas.Recipe].self) { [weak self] group in
                guard case let .success(vibeRecipe) = self?.state.vibeRecipe else {
                    return []
                }
                vibeRecipe.recipeIds.forEach { recipeID in
                    group.addTask {
                        try await self?.recipeService.getRecipe(id: recipeID)
                    }
                }
                var recipes: [Components.Schemas.Recipe] = []
                for try await recipe in group {
                    guard let recipe else {
                        continue
                    }
                    recipes.append(recipe)
                }
                return recipes
            }
            state.recipes = .success(recipes)
        } catch {
            Logger.error(error)
            state.recipes = .failure(.init(error))
            return
        }

        guard
            case let .success(vibeRecipe) = state.vibeRecipe,
            case let .success(recipes) = state.recipes
        else {
            return
        }
        let recipeInstructions = recipes.flatMap { $0.instructions }
        let instructions = vibeRecipe.vibeInstructions.sorted(by: { $0.step < $1.step }).map { vibeInstruction in
            recipeInstructions.first {
                $0.id == vibeInstruction.instructionId && $0.recipeId == vibeInstruction.recipeId
            }
        }.compactMap { $0 }
        state.instructions = .success(instructions)

        guard let instruction = instructions.first else {
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

private extension VibeCookingPresenter {
    func startSpeechRecognition() async {
        state.isRecognizingVoice = true
        for await voiceCommand in await cookingService.startListening() {
            switch voiceCommand {
            case .goBack:
                if state.currentInstructionStep > 1 {
                    state.currentInstructionStep -= 1
                }
            case .goForward:
                guard case let .success(instructions) = state.instructions else {
                    return
                }
                if state.currentInstructionStep < instructions.count {
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
