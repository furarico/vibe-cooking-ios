//
//  VibeCooking
//
//

import SwiftUI

struct RecipeCardList: View {
    let recipes: [Components.Schemas.Recipe]
    
    var body: some View {
        if !recipes.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recipes, id: \.id) { recipe in
                        RecipeCard(
                            variant: .card,
                            title: recipe.title,
                            description: recipe.description,
                            tags: recipe.tags,
                            cookingTime: recipe.prepTime + recipe.cookTime,
                            imageUrl: recipe.imageUrl ?? "",
                            imageAlt: recipe.title
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    RecipeCardList(recipes: Components.Schemas.Recipe.stubs)
}
