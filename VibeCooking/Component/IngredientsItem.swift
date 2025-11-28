//
//  IngredientsItem.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct IngredientsItem: View {
    let ingredient: Ingredient

    var body: some View {
        HStack {
            Text(ingredient.name)
                .fontWeight(.medium)
            if let notes = ingredient.notes, !notes.isEmpty {
                Text(notes)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("\(ingredient.amount.formatted(.number)) \(ingredient.unit)")
        }
        .padding(8)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8)),
            alignment: .bottom
        )
    }
}

#Preview {
    IngredientsItem(ingredient: .stub0)
}

#Preview {
    IngredientsItem(ingredient: .stub1)
}

#Preview {
    IngredientsItem(ingredient: .stub2)
}

#Preview {
    IngredientsItem(ingredient: .stub3)
}
