//
//  RecipeDetailHeader.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeDetailHeader: View {
    private let recipe: Components.Schemas.Recipe

    init(recipe: Components.Schemas.Recipe) {
        self.recipe = recipe
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                if !recipe.title.isEmpty {
                    Text(recipe.title)
                        .font(.title3)
                        .bold()
                }
                
                if !recipe.description.isEmpty {
                    Text(recipe.description)
                        .font(.footnote)
                        .fontWeight(.medium)
                }
            }
            
            if !recipe.tags.isEmpty {
                let tagString = recipe.tags.map { "#\($0)" }.joined(separator: " ")
                Text(tagString)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RecipeDetailHeader(recipe: .stub0)
}

#Preview {
    RecipeDetailHeader(recipe: .stub1)
}

#Preview {
    RecipeDetailHeader(recipe: .stub2)
}
