//
//  ContentScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct ContentScreen<Environment: EnvironmentProtocol>: View {
    @State private var presenter = ContentPresenter<Environment>()

    var body: some View {
        NavigationStack {
            RecipeListScreen<Environment>()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presenter.dispatch(.onVibeCookingListButtonTapped)
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
        }
        .sheet(isPresented: $presenter.state.isVibeCookingListPresented) {
            VibeCookingListScreen<Environment>() { recipeIDs in
                presenter.dispatch(.onStartVibeCookingButtonTapped(recipeIDs: recipeIDs))
            }
        }
        .fullScreenCover(isPresented: $presenter.state.isVibeCookingPresented) {
            VibeCookingScreen<Environment>(
                recipeIDs: presenter.state.vibeCookingListRecipeIDs
            )
        }
    }
}

#Preview {
    ContentScreen<MockEnvironment>()
}
