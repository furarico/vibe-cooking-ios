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
            Text(presenter.state.recipe.title)

            instructions

            ProgressView(
                "\(presenter.state.currentInstructionStep) / \(presenter.state.recipe.instructions.count)",
                value: Double(presenter.state.currentInstructionStep),
                total: Double(presenter.state.recipe.instructions.count)
            )
            .padding()

            Text(presenter.state.transcript)

            Button("終了") {
                dismiss()
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
                    instructionCard(instruction: instruction)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $presenter.state.currentInstructionID)
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 16)
    }

    private func instructionCard(instruction: Components.Schemas.Instruction) -> some View {
        VStack {
            Text(instruction.description)
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .containerRelativeFrame(.horizontal)
        .background(
            Color.secondary,
            in: .rect(cornerRadius: 8)
        )
    }
}

#Preview {
    CookingScreen<MockEnvironment>(recipe: .stub0)
}
