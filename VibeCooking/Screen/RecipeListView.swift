//
//  RecipeListView.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeListView<Environment: EnvironmentProtocol>: View {
    @State private var presenter = RecipeListPresenter<Environment>()

    var body: some View {
        content
            .task {
                await presenter.dispatch(.onAppear)
            }
            .alert(presenter.state.recipes)
    }

    @ViewBuilder
    private var content: some View {
        switch presenter.state.recipes {
        case .success(let recipes), .reloading(let recipes):
            List(recipes, id: \.id) { recipe in
                Text(recipe.title ?? "")
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
    RecipeListView<MockEnvironment>()
}
