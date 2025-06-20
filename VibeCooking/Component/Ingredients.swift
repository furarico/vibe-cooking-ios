//
//  VibeCooking
//
//

import SwiftUI

struct Ingredients: View {
    private let ingredients: [Components.Schemas.Ingredient]
    private let label: String

    init(
        ingredients: [Components.Schemas.Ingredient],
        label: String = "材料"
    ) {
        self.ingredients = ingredients
        self.label = label
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)

            VStack {
                ForEach(ingredients) { ingredient in
                    IngredientsItem(ingredient: ingredient)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    Ingredients(ingredients: Components.Schemas.Ingredient.stubs0)
}

#Preview {
    Ingredients(ingredients: Components.Schemas.Ingredient.stubs1)
}

#Preview {
    Ingredients(ingredients: Components.Schemas.Ingredient.stubs2)
}
