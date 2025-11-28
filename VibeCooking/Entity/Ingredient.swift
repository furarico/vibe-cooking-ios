//
//  Ingredient.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

struct Ingredient: Equatable, Identifiable {
    let id: String
    let name: String
    let amount: Int
    let unit: String
    let notes: String?
}
