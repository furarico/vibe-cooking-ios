//
//  VibeCooking
//
//

import SwiftUI

struct Ingredients: View {
    private let ingredients: [Components.Schemas.Ingredient]

    init(ingredients: [Components.Schemas.Ingredient]) {
        self.ingredients = ingredients
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("材料")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
            
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
