//
//  RecipeListScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeListScreen: View {
    @State private var presenter = RecipeListPresenter()

    var body: some View {
        content
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailScreen(recipeID: recipe.id)
            }
            .task {
                await presenter.dispatch(.onAppear)
            }
            .alert(presenter.state.recipes)
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.recipes {
        case .success(let recipes), .reloading(let recipes):
            if recipes.isEmpty {
                noContent
            } else {
                List (recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeCard(recipe: recipe)
                    }
                }
            }

        case .loading, .retrying:
            ProgressView()

        case .idle:
            Color.clear

        case .failure:
            noContent
        }
    }

    private var noContent: some View {
        ContentUnavailableView(
            "レシピが見つかりません",
            systemImage: "list.bullet.clipboard"
        )
    }
}

#Preview {
    RecipeListScreen()
}
