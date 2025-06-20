//
//  CookingScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct CookingScreen<Environment: EnvironmentProtocol>: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @State private var presenter: CookingPresenter<Environment>

    init(recipe: Components.Schemas.Recipe) {
        presenter = .init(recipe: recipe)
    }

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        RecipeCard(variant: .row, recipe: presenter.state.recipe)
                            .padding()

                        instructions

                        InstructionProgress(
                            totalSteps: presenter.state.recipe.instructions.count,
                            currentStep: presenter.state.currentInstructionStep
                        )
                        .padding()

                        if presenter.state.isRecognizingVoice {
                            Image(systemName: "microphone.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.orange)
                        } else {
                            Image(systemName: "microphone.slash.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.red)
                        }
                    }
                }

                Button("終了") {
                    dismiss()
                }
                .padding()
            }
        }
        .task {
            presenter.dispatch(.onAppear)
        }
        .onDisappear {
            presenter.dispatch(.onDisappear)
        }
    }

    private var instructions: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(presenter.state.recipe.instructions) { instruction in
                    InstructionsItem(variant: .card, instruction: instruction)
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
}

#Preview {
    CookingScreen<MockEnvironment>(recipe: .stub0)
}
