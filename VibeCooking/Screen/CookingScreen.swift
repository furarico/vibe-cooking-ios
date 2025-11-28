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

    init(recipe: Components.Schemas.Recipe) {
        presenter = .init(recipe: recipe)
    }

    var body: some View {
        VStack {
            RecipeCard(recipe: presenter.state.recipe)
                .padding(.horizontal)

            instructions

            timerControl
                .padding(.horizontal)

            InstructionProgress(
                totalSteps: presenter.state.recipe.instructions.count,
                currentStep: presenter.state.currentInstructionStep
            )
            .padding(.horizontal)

            animation
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

    private var instructions: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(presenter.state.recipe.instructions) { instruction in
                    ScrollView {
                        InstructionsItem(instruction: instruction)
                    }
                    .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
            .padding(.vertical, 16)
        }
        .scrollPosition(id: $presenter.state.currentInstructionID)
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 16)
        .onChange(of: presenter.state.currentInstructionID) { _, newValue in
            if let newValue,
               let instruction = presenter.state.recipe.instructions.first(where: { $0.id == newValue }) {
                presenter.dispatch(.onInstructionChanged(instruction))
            }
        }
    }

    @ViewBuilder
    private var timerControl: some View {
        TimerPopup(interval: 60) {
        }
    }

    @ViewBuilder
    private var animation: some View {
        if presenter.state.isRecognizingVoice {
            LottieView(name: "listening")
        } else {
            LottieView(name: "speaking")
        }
    }
}

#Preview {
    CookingScreen(recipe: .stub0)
}
