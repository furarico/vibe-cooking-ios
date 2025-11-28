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
        HStack(spacing: 16) {
            image
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(12)
            contentView
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.body)
                    .bold()
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                
                Text(recipe.description)
                    .font(.caption)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
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
}
