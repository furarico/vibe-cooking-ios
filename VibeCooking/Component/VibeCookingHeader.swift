//
//  VibeCookingHeader.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import SwiftUI

struct VibeCookingHeader: View {
    private let recipes: [Components.Schemas.Recipe]
    private let selectedRecipeID: Components.Schemas.Recipe.ID?

    init(
        recipes: [Components.Schemas.Recipe],
        selectedRecipeID: Components.Schemas.Recipe.ID?
    ) {
        self.recipes = recipes
        self.selectedRecipeID = selectedRecipeID
    }

    var body: some View {
        HStack(spacing: 16) {
            contentView

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(recipes) { recipe in
                Text(recipe.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(recipe.id == selectedRecipeID ? .primary : .secondary)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    VibeCookingHeader(
        recipes: Components.Schemas.Recipe.stubs,
        selectedRecipeID: Components.Schemas.Recipe.stub0.id
    )
}
