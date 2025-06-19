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
                            title: recipe.title ?? "",
                            description: recipe.description ?? "",
                            tags: recipe.tags ?? [],
                            cookingTime: (recipe.prepTime ?? 0) + (recipe.cookTime ?? 0),
                            imageUrl: recipe.imageUrl ?? "",
                            imageAlt: recipe.title ?? ""
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }
}

struct RecipeCardList_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRecipes: [Components.Schemas.Recipe] = [
            Components.Schemas.Recipe(
                id: "1",
                title: "チキンカレー",
                description: "スパイシーで美味しいチキンカレーです。",
                tags: ["カレー", "チキン"],
                prepTime: 15,
                cookTime: 30,
                imageUrl: "https://example.com/curry.jpg"
            ),
            Components.Schemas.Recipe(
                id: "2",
                title: "パスタボロネーゼ",
                description: "本格的なボロネーゼソースのパスタです。",
                tags: ["パスタ", "イタリアン"],
                prepTime: 10,
                cookTime: 20,
                imageUrl: "https://example.com/pasta.jpg"
            )
        ]
        
        return RecipeCardList(recipes: sampleRecipes)
    }
}
