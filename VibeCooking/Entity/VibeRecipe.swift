//
//  VibeRecipe.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

struct VibeRecipe: RecipeProtocol {
    let id: String
    let recipes: [Recipe]
    let instructions: [Instruction]
}
