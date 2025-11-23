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
                ZStack {
                    VStack {
                        List {
                            ForEach(recipes) { recipe in
                                RecipeCard(recipe: recipe)
                            }
                            .onDelete { offsets in
                                presenter.dispatch(.onDelete(offsets: offsets))
                            }
                        }

                        ScrollView {
                            LazyVStack(spacing: 24) {
                                ForEach(recipes) { recipe in
                                    Ingredients(
                                        ingredients: recipe.ingredients,
                                        label: recipe.title
                                    )
                                }
                            }
                            .padding()

                            Color.clear
                                .frame(height: 48)
                        }
                    }

                    VStack {
                        Spacer()
                        VibeCookingButton("Vibe Cooking をはじめる") {
                            onStartVibeCookingButtonTapped(recipes.map(\.id))
                        }
                        .font(.footnote)
                        .lineLimit(1)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        .clear,
                                        .white.opacity(0.4),
                                    ]
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
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
