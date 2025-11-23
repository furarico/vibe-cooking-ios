//
//  RecipeCardList.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeCardList: View {
    let recipes: [Components.Schemas.Recipe]

    var body: some View {
        List(recipes) { recipe in
            RecipeCard(recipe: recipe)
        }
    }
}

#Preview {
    RecipeCardList(recipes: Components.Schemas.Recipe.stubs)
}
