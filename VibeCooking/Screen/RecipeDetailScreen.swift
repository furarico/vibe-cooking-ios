//
//  RecipeDetailScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import NukeUI
import SwiftUI

struct RecipeDetailScreen: View {
    @State private var presenter: RecipeDetailPresenter

    init(recipeID: String) {
        presenter = .init(recipeID: recipeID)
    }

    var body: some View {
        content
            .task {
                await presenter.dispatch(.onAppear)
            }
            .alert(presenter.state.recipe)
            .alert(presenter.state.vibeCookingList)
            .fullScreenCover(isPresented: $presenter.state.isCookingScreenPresented) {
                if case .success(let recipe) = presenter.state.recipe {
                    CookingScreen(recipe: recipe)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    switch presenter.state.vibeCookingList {
                    case .success:
                        if let isInList = presenter.state.isInVibeCookingList {
                            Button {
                                presenter.dispatch(.onAddToOrRemoveFromVibeCookingListButtonTapped)
                            } label: {
                                Image(systemName: isInList ? "checkmark" : "plus")
                            }
                        } else {
                            EmptyView()
                        }

                    default:
                        EmptyView()
                    }
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.recipe {
        case .success(let recipe), .reloading(let recipe):
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        LazyImage(url: URL(string: recipe.imageUrl ?? "")) { state in
                            if let image = state.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else if state.error != nil {
                                noImage
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                        .cornerRadius(8)

                        RecipeDetailHeader(recipe: recipe)

                        Ingredients(ingredients: recipe.ingredients)

                        Instructions(instructions: recipe.instructions)

                        Color.clear
                            .frame(height: 48)
                    }
                    .padding()
                }

                VStack {
                    Spacer()
                    VibeCookingButton("このレシピのみで Vibe Cooking をはじめる") {
                        presenter.dispatch(.onVibeCookingButtonTapped)
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
    RecipeDetailScreen(recipeID: "")
}
