//
//  VibeCooking
//
//

import SwiftUI

struct RecipeCardList: View {
    enum Variant {
        case cards
        case list
    }

    private let variant: Variant
    private let recipes: [Components.Schemas.Recipe]
    private let onDelete: ((Components.Schemas.Recipe.ID) -> Void)?

    init(
        variant: Variant = .cards,
        recipes: [Components.Schemas.Recipe],
        onDelete: ((Components.Schemas.Recipe.ID) -> Void)? = nil
    ) {
        self.variant = variant
        self.recipes = recipes
        self.onDelete = onDelete
    }

    var body: some View {
        switch variant {
        case .cards:
            HStack(spacing: 16) {
                ForEach(recipes) { recipe in
                    RecipeCard(
                        variant: .card,
                        recipe: recipe,
                        onDelete: onDelete
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

        case .list:
            VStack(alignment: .leading, spacing: 16) {
                ForEach(recipes) { recipe in
                    RecipeCard(
                        variant: .row,
                        recipe: recipe,
                        onDelete: onDelete
                    )
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        RecipeCardList(recipes: Components.Schemas.Recipe.stubs)
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        RecipeCardList(variant: .cards, recipes: Components.Schemas.Recipe.stubs)
    }
}

#Preview {
    ScrollView(.vertical, showsIndicators: false) {
        RecipeCardList(variant: .list, recipes: Components.Schemas.Recipe.stubs)
    }
}

#Preview {
    ScrollView(.vertical, showsIndicators: false) {
        RecipeCardList(variant: .list, recipes: Components.Schemas.Recipe.stubs) { _ in
        }
    }
}
