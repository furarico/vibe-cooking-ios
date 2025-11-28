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
        case .success(let vibeCooking), .reloading(let vibeCooking):
            VStack {
                VibeCookingHeader(
                    recipes: vibeCooking.recipes,
                    selectedRecipeID: presenter.state.currentRecipe?.id
                )
                .padding(.horizontal)

                instructions(instructions: vibeCooking.instructions)

                InstructionProgress(
                    totalSteps: vibeCooking.instructions.count,
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
}

#Preview {
    VibeCookingScreen(recipeIDs: [])
}
