//
//  Ingredients.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct Ingredients: View {
    private let ingredients: [Ingredient]
    private let label: String

    init(
        ingredients: [Ingredient],
        label: String = "材料"
    ) {
        self.ingredients = ingredients
        self.label = label
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .font(.title3)
                .bold()
                .lineLimit(1)
                .padding(.horizontal, 8)

            VStack {
                ForEach(ingredients) { ingredient in
                    IngredientsItem(ingredient: ingredient)
                }
            }
        }
    }
}

#Preview {
    Ingredients(ingredients: Ingredient.stubs0)
}

#Preview {
    Ingredients(ingredients: Ingredient.stubs1)
}

#Preview {
    Ingredients(ingredients: Ingredient.stubs2)
}
