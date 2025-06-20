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
                            case .failure, .empty:
                                noImage

                            @unknown default:
                                noImage
                            }
                        }
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .border(Color.secondary, width: 1)

                        RecipeDetailHeader(recipe: recipe)

                        Ingredients(ingredients: recipe.ingredients)

                        Instructions(instructions: recipe.instructions)
                    }
                    .padding()
                }

                Button("Vibe Cooking") {
                    presenter.dispatch(.onVibeCookingButtonTapped)
                }
            }

        case .loading, .retrying:
            ProgressView()

        case .idle, .failure:
            ContentUnavailableView(
                "Recipe not found",
                systemImage: "list.bullet.clipboard"
            )
        }
    }

    private var noImage: some View {
        Image(.default)
            .resizable()
    }
}

#Preview {
    RecipeDetailScreen<MockEnvironment>(recipeID: "")
}
