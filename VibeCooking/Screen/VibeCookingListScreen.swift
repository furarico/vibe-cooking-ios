//
//  VibeCookingListScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import SwiftUI

struct VibeCookingListScreen<Environment: EnvironmentProtocol>: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @State private var presenter = VibeCookingListPresenter<Environment>()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Vibe Cooking リスト")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("完了") {
                        dismiss()
                    }
                }
        }
        .task {
            await presenter.dispatch(.onAppear)
        }
        .alert(presenter.state.recipes)
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.recipes {
        case .loading, .retrying:
            ProgressView()

        case .success(let recipes), .reloading(let recipes):
            if recipes.isEmpty {
                noContent
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(recipes) { recipe in
                            RecipeCard(variant: .row, recipe: recipe) { id in
                                presenter.dispatch(.onDelete(id: id))
                            }
                        }
                    }
                    .padding()
                }
            }

        case .idle:
            Color.clear

        case .failure:
            noContent
        }
    }

    private var noContent: some View {
        ContentUnavailableView(
            "No recipes found",
            systemImage: "list.bullet.clipboard"
        )
    }
}

#Preview {
    VibeCookingListScreen<MockEnvironment>()
}
