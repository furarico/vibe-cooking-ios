//
//  VibeCooking
//
//

import SwiftUI

struct IngredientsItem: View {
    private let ingredient: Components.Schemas.Ingredient

    init(ingredient: Components.Schemas.Ingredient) {
        self.ingredient = ingredient
    }

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Text(ingredient.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                if let notes = ingredient.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            Text("\(ingredient.amount) \(ingredient.unit)")
                .font(.system(size: 16))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8)),
            alignment: .bottom
        )
    }
}

#Preview {
    IngredientsItem(ingredient: Components.Schemas.Ingredient.stub0)
}

#Preview {
    IngredientsItem(ingredient: Components.Schemas.Ingredient.stub1)
}

#Preview {
    IngredientsItem(ingredient: Components.Schemas.Ingredient.stub2)
}

#Preview {
    IngredientsItem(ingredient: Components.Schemas.Ingredient.stub3)
}
