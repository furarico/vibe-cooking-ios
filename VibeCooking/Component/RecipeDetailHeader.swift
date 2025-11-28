//
//  RecipeDetailHeader.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct RecipeDetailHeader: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
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
