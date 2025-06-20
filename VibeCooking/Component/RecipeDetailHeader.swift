//
//  VibeCooking
//
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
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                if !recipe.description.isEmpty {
                    Text(recipe.description)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                }
            }
            
            if !recipe.tags.isEmpty {
                HStack {
                    ForEach(recipe.tags, id: \.self) { tag in
                        Button(action: {
                        }) {
                            Text("#\(tag)")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                }
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
