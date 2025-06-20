//
//  VibeCookingScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import SwiftUI

struct VibeCookingScreen<Environment: EnvironmentProtocol>: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @State private var presenter: VibeCookingPresenter<Environment>

    init(recipeIDs: [String]) {
        self.presenter = .init(recipeIDs: recipeIDs)
    }

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
//                        RecipeCard(variant: .row, recipe: presenter.state.recipe)
//                            .padding()

                        instructions

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

                VibeCookingButton("Vibe Cooking をおわる") {
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

    @ViewBuilder
    private var instructions: some View {
        switch presenter.state.instructions {
        case .success(let instructions), .reloading(let instructions):
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(instructions) { instruction in
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
                   let instruction = instructions.first(where: { $0.id == newValue }) {
                    presenter.dispatch(.onInstructionChanged(instruction: instruction))
                }
            }

            InstructionProgress(
                totalSteps: instructions.count,
                currentStep: presenter.state.currentInstructionStep
            )
            .padding()

        case .loading, .retrying:
            ProgressView()

        case .idle, .failure:
            EmptyView()
        }
    }
}

#Preview {
    VibeCookingScreen<MockEnvironment>(recipeIDs: [])
}
