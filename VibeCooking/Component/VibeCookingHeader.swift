//
//  VibeCookingHeader.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import SwiftUI

struct VibeCookingHeader: View {
    let recipes: [Recipe]
    let selectedRecipeID: Recipe.ID

    var body: some View {
        HStack(spacing: 16) {
            contentView
            Spacer()
        }
        .frame(maxWidth: .infinity)
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
        recipes: Recipe.stubs,
        selectedRecipeID: Recipe.stub0.id
    )
    .padding()
}
