//
//  VibeCooking
//
//

import SwiftUI

enum RecipeCardVariant {
    case card
    case row
}

struct RecipeCard: View {
    let variant: RecipeCardVariant
    let title: String
    let description: String
    let tags: [String]
    let cookingTime: Int
    let imageUrl: String
    let imageAlt: String
    let onDelete: (() -> Void)?
    
    init(
        variant: RecipeCardVariant = .card,
        title: String,
        description: String,
        tags: [String],
        cookingTime: Int,
        imageUrl: String,
        imageAlt: String,
        onDelete: (() -> Void)? = nil
    ) {
        self.variant = variant
        self.title = title
        self.description = description
        self.tags = tags
        self.cookingTime = cookingTime
        self.imageUrl = imageUrl
        self.imageAlt = imageAlt
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
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
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
                Button(action: onDelete) {
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
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
            )
            
            contentView
            
            Spacer()
            
            if let onDelete = onDelete {
                Button(action: onDelete) {
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
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }
            
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
            
            HStack(spacing: 4) {
                Image(systemName: "clock")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text("\(cookingTime)min")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            RecipeCard(
                variant: .card,
                title: "チキンカレー",
                description: "スパイシーで美味しいチキンカレーです。家族みんなで楽しめます。",
                tags: ["カレー", "チキン", "スパイス"],
                cookingTime: 45,
                imageUrl: "https://example.com/image.jpg",
                imageAlt: "チキンカレー",
                onDelete: {}
            )
            
            RecipeCard(
                variant: .row,
                title: "パスタボロネーゼ",
                description: "本格的なボロネーゼソースのパスタです。",
                tags: ["パスタ", "イタリアン"],
                cookingTime: 30,
                imageUrl: "https://example.com/image.jpg",
                imageAlt: "パスタボロネーゼ"
            )
        }
        .padding()
    }
}
