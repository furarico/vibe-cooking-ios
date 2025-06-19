//
//  RecipeListScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeListScreen<Environment: EnvironmentProtocol>: View {
    @State private var presenter = RecipeListPresenter<Environment>()

    var body: some View {
        content
            .navigationDestination(for: Components.Schemas.Recipe.self) { recipe in
                RecipeDetailScreen<Environment>(recipeID: recipe.id ?? "")
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
            List(recipes) { recipe in
                NavigationLink(recipe.title ?? "", value: recipe)
            }

        case .loading, .retrying:
            ProgressView()

        case .idle, .failure:
            ContentUnavailableView(
                "No recipes found",
                systemImage: "list.bullet.clipboard"
            )
        }
    }
}

#Preview {
    RecipeListScreen<MockEnvironment>()
}
