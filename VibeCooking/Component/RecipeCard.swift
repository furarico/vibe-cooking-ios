//
//  RecipeCard.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import NukeUI
import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            image
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                }
            contentView
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recipe.title)
                .font(.body)
                .bold()
                .lineLimit(1)
                .multilineTextAlignment(.leading)

            Text(recipe.description)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var image: some View {
        LazyImage(url: recipe.imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if state.error != nil {
                defaultImage
            } else {
                ProgressView()
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
        .padding()
}
