//
//  VibeCookingScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import SwiftUI

struct VibeCookingScreen: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @State private var presenter: VibeCookingPresenter

    init(recipeIDs: [String]) {
        self.presenter = .init(recipeIDs: recipeIDs)
    }

    var body: some View {
        content
            .padding(.vertical)
            .task {
                presenter.dispatch(.onAppear)
            }
            .onDisappear {
                presenter.dispatch(.onDisappear)
            }
            .alert(presenter.state.vibeRecipe)
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.vibeRecipe {
        case .success(let recipes), .reloading(let recipes):
            VStack {
                if let selectedRecipeID = presenter.state.currentInstruction?.recipeID {
                    VibeCookingHeader(
                        recipes: recipes,
                        selectedRecipeID: selectedRecipeID
                    )
                    .padding(.horizontal)
                }

                instructions(instructions: presenter.state.instructions ?? [])

                timerControl
                    .padding(.horizontal)

                InstructionProgress(
                    totalSteps: presenter.state.instructions?.count ?? 1,
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

        case .loading, .retrying:
            VStack {
                ProgressView()
                Text("レシピを構築中...")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

        case .idle:
            Color.clear

        case .failure:
            VStack {
                ContentUnavailableView(
                    "レシピの構築に失敗しました",
                    systemImage: "list.bullet.clipboard"
                )
                .frame(height: .infinity)

                VibeCookingButton("もう一度試す") {
                    dismiss()
                }
                .padding()
            }
        }
    }

    private func instructions(instructions: [Instruction]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(instructions, id: \.step) { instruction in
                    ScrollView {
                        InstructionsItem(instruction: instruction)
                    }
                    .padding(.horizontal, 4)
                    .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
            .padding(.vertical)
        }
        .scrollPosition(id: $presenter.state.currentStep)
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 12)
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
    VibeCookingScreen(recipeIDs: [])
}
