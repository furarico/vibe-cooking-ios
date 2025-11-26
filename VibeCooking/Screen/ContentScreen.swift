//
//  ContentScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct ContentScreen: View {
    @State private var presenter = ContentPresenter()

    var body: some View {
        NavigationStack {
            RecipeListScreen()
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
            VibeCookingListScreen() { recipeIDs in
                presenter.dispatch(.onStartVibeCookingButtonTapped(recipeIDs: recipeIDs))
            }
        }
        .fullScreenCover(isPresented: $presenter.state.isVibeCookingPresented) {
            VibeCookingScreen(
                recipeIDs: presenter.state.vibeCookingListRecipeIDs
            )
        }
    }
}

#Preview {
    ContentScreen()
}
