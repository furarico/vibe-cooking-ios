//
//  CookingScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct CookingScreen: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @State private var presenter: CookingPresenter

    init(recipe: Recipe) {
        presenter = .init(recipe: recipe)
    }

    var body: some View {
        VStack {
            RecipeCard(recipe: presenter.state.recipe)
                .padding(.horizontal)

            instructions(instructions: presenter.state.recipe.instructions)

            timerControl
                .padding(.horizontal)

            InstructionProgress(
                totalSteps: presenter.state.recipe.instructions.count,
                currentStep: presenter.state.currentStep ?? 1
            )
            .padding(.horizontal)

            VibeChefAnimation(isListening: presenter.state.isRecognizingVoice)
                .frame(height: 80)

            VibeCookingButton("Vibe Cooking をおわる") {
                dismiss()
            }
            .font(.footnote)
            .lineLimit(1)
            .padding(.horizontal)
        }
        .padding(.vertical)
        .task {
            presenter.dispatch(.onAppear)
        }
        .onDisappear {
            presenter.dispatch(.onDisappear)
        }
    }

    private func instructions(instructions: [Instruction]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(instructions, id: \.step) { instruction in
                    ScrollView {
                        InstructionsItem(instruction: instruction)
                    }
                    .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
            .padding(.vertical)
        }
        .scrollPosition(id: $presenter.state.currentStep)
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 16)
        .onChange(of: presenter.state.currentStep) { _, _ in
            presenter.dispatch(.onInstructionChanged)
        }
    }

    @ViewBuilder
    private var timerControl: some View {
        if let instruction = presenter.state.currentInstruction {
            if let timer = presenter.state.cookingTimers.first(where: { $0.instructionID == instruction.id }) {
                RunningTimerPopup(timer: timer) {
                    presenter.dispatch(.onStopTimerButtonTapped)
                }
            } else if let interval = instruction.timerDuration {
                TimerPopup(interval: interval) {
                    presenter.dispatch(.onStartTimerButtonTapped)
                }
            }
        }
    }
}

#Preview {
    CookingScreen(recipe: .stub0)
}
