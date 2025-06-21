//
//  RecipeDetailScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeDetailScreen<Environment: EnvironmentProtocol>: View {
    @State private var presenter: RecipeDetailPresenter<Environment>

    init(recipeID: String) {
        presenter = .init(recipeID: recipeID)
    }

    var body: some View {
        content
            .task {
                await presenter.dispatch(.onAppear)
            }
            .alert(presenter.state.recipe)
            .fullScreenCover(isPresented: $presenter.state.isCookingScreenPresented) {
                if case .success(let recipe) = presenter.state.recipe {
                    CookingScreen<Environment>(recipe: recipe)
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.recipe {
        case .success(let recipe), .reloading(let recipe):
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        AsyncImage(url: URL(string: recipe.imageUrl ?? "")) { result in
                            switch result {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)

                            case .failure:
                                noImage

                            case .empty:
                                noImage

                            @unknown default:
                                noImage
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1)
                        )

                        RecipeDetailHeader(recipe: recipe)

                        Ingredients(ingredients: recipe.ingredients)

                        Instructions(instructions: recipe.instructions)
                    }
                    .padding()
                }

                VStack {
                    VibeCookingButton("このレシピのみで Vibe Cooking をはじめる") {
                        presenter.dispatch(.onVibeCookingButtonTapped)
                    }

                    switch presenter.state.vibeCookingList {
                    case .success(let vibeCookingList):
                        if presenter.state.isOnVibeCookingList ?? false {
                            VibeCookingButton("Vibe Cooking リストから削除") {
                                presenter.dispatch(.onVibeCookingListButtonTapped)
                            }
                        } else {
                            VibeCookingButton("Vibe Cooking リストに追加") {
                                presenter.dispatch(.onVibeCookingListButtonTapped)
                            }
                            .disabled(vibeCookingList.count >= 3)
                        }

                    case .loading, .reloading:
                        ProgressView()

                    default:
                        EmptyView()
                    }
                }
                .padding()
            }

        case .loading, .retrying:
            ProgressView()

        case .idle, .failure:
            ContentUnavailableView(
                "レシピが見つかりません",
                systemImage: "list.bullet.clipboard"
            )
        }
    }

    private var noImage: some View {
        Image(.default)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    RecipeDetailScreen<MockEnvironment>(recipeID: "")
}
