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
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.recipe {
        case .success(let recipe), .reloading(let recipe):
            Text(recipe.title ?? "")

        case .loading, .retrying:
            ProgressView()

        case .idle, .failure:
            ContentUnavailableView(
                "Recipe not found",
                systemImage: "list.bullet.clipboard"
            )
        }
    }
}

#Preview {
    RecipeDetailScreen<MockEnvironment>(recipeID: "")
}
