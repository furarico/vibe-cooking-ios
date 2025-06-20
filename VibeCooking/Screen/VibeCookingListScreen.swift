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
    private let onStartVibeCookingButtonTapped: ([String]) -> Void

    init(onStartVibeCookingButtonTapped: @escaping ([String]) -> Void) {
        self.onStartVibeCookingButtonTapped = onStartVibeCookingButtonTapped
    }

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
                VStack {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(recipes) { recipe in
                                RecipeCard(variant: .row, recipe: recipe) { id in
                                    presenter.dispatch(.onDelete(id: id))
                                }
                            }
                        }
                        .padding()

                        LazyVStack(spacing: 24) {
                            ForEach(recipes) { recipe in
                                Ingredients(
                                    ingredients: recipe.ingredients,
                                    label: recipe.title
                                )
                            }
                        }
                        .padding()
                    }

                    VibeCookingButton("Vibe Cooking をはじめる") {
                        onStartVibeCookingButtonTapped(recipes.map(\.id))
                    }
                    .disabled(recipes.count > 3 || recipes.isEmpty)
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
            "リストに追加されたレシピはありません",
            systemImage: "list.bullet.clipboard"
        )
    }
}

#Preview {
    VibeCookingListScreen<MockEnvironment>() { _ in
    }
}
