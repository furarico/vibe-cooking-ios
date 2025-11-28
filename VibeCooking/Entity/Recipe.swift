//
//  Recipe.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

protocol RecipeProtocol: Equatable, Identifiable {
    var id: String { get }
    var ingredients: [Ingredient] { get }
    var instructions: [Instruction] { get }
}

struct Recipe: RecipeProtocol {
    let id: String
    let title: String?
    let description: String?
    let ingredients: [Ingredient]
    let instructions: [Instruction]
    let imageURL: URL?
}

struct VibeRecipe: RecipeProtocol {
    let id: String
    let recipeIDs: [String]
    let ingredients: [Ingredient]
    let instructions: [Instruction]
}
