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
        content
            .task {
                presenter.dispatch(.onAppear)
            }
            .onDisappear {
                presenter.dispatch(.onDisappear)
            }
            .alert(presenter.state.vibeRecipe)
            .alert(presenter.state.recipes)
            .alert(presenter.state.instructions)
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.vibeRecipe {
        case .success, .reloading:
            VStack {
                VStack(spacing: 24) {
                    recipes

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

                VibeCookingButton("Vibe Cooking をおわる") {
                    dismiss()
                }
                .padding()
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

    @ViewBuilder
    private var recipes: some View {
        switch presenter.state.recipes {
        case .success(let recipes), .reloading(let recipes):
            VibeCookingHeader(
                recipes: recipes,
                selectedRecipeID: presenter.state.currentRecipe?.id
            )
            .padding()

        case .loading, .retrying:
            EmptyView()

        case .idle, .failure:
            EmptyView()
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
            EmptyView()

        case .idle, .failure:
            EmptyView()
        }
    }
}

#Preview {
    VibeCookingScreen<MockEnvironment>(recipeIDs: [])
}
