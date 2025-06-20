//
//  VibeCooking
//
//

import SwiftUI

struct RecipeCard: View {
    enum Variant {
        case card
        case row
    }

    private let variant: Variant
    private let recipe: Components.Schemas.Recipe
    private let onDelete: ((Components.Schemas.Recipe.ID) -> Void)?

    init(
        variant: Variant = .card,
        recipe: Components.Schemas.Recipe,
        onDelete: ((Components.Schemas.Recipe.ID) -> Void)? = nil
    ) {
        self.variant = variant
        self.recipe = recipe
        self.onDelete = onDelete
    }

    var body: some View {
        Group {
            if variant == .card {
                cardLayout
            } else {
                rowLayout
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private var cardLayout: some View {
        VStack(alignment: .leading, spacing: 16) {
            image
                .frame(height: 100)
                .clipped()
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                )

            contentView
        }
        .frame(maxWidth: 220)
        .padding(16)
        .overlay(alignment: .topTrailing) {
            if let onDelete = onDelete {
                Button {
                    onDelete(recipe.id)
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                }
                .padding(8)
            }
        }
    }

    private var rowLayout: some View {
        HStack(spacing: 16) {
            image
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1)
                )

            contentView

            Spacer()

            if let onDelete = onDelete {
                Button {
                    onDelete(recipe.id)
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                }
            }
        }
        .padding(16)
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(recipe.description)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }

            HStack {
                ForEach(recipe.tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }

            HStack(spacing: 4) {
                Image(systemName: "clock")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)

                Text("\(recipe.prepTime + recipe.cookTime)min")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }
        }
    }

    private var image: some View {
        AsyncImage(url: URL(string: recipe.imageUrl ?? "")) { result in
            switch result {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)

            case .failure:
                defaultImage

            case .empty:
                defaultImage

            @unknown default:
                defaultImage
            }
        }
    }

    private var defaultImage: some View {
        Image(.default)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    RecipeCard(recipe: .stub0)
}

#Preview {
    RecipeCard(variant: .card, recipe: .stub0)
}

#Preview {
    RecipeCard(variant: .row, recipe: .stub0)
}

#Preview {
    RecipeCard(variant: .row, recipe: .stub0) { _ in
    }
}
