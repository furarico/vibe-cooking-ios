//
//  Recipe.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

struct Recipe: RecipeProtocol {
    let id: String
    let title: String
    let description: String
    let ingredients: [Ingredient]
    let instructions: [Instruction]
    let imageURL: URL?
}

extension Recipe {
    static let stub0 = Recipe(
        id: "recipe_001",
        title: "チキンカレー",
        description: "スパイシーで美味しいチキンカレーです。家庭で簡単に作れます。",
        ingredients: Ingredient.stubs0,
        instructions: Instruction.stubs0,
        imageURL: URL(string: "https://r2.vibe-cooking.app/images/default.png")
    )

    static let stub1 = Recipe(
        id: "recipe_002",
        title: "パスタボロネーゼ",
        description: "本格的なボロネーゼソースで作るパスタです。",
        ingredients: Ingredient.stubs1,
        instructions: Instruction.stubs1,
        imageURL: URL(string: "https://r2.vibe-cooking.app/images/default.png")
    )

    static let stub2 = Recipe(
        id: "recipe_003",
        title: "親子丼",
        description: "ふわふわ卵の親子丼です。お手軽に作れる定番料理。",
        ingredients: Ingredient.stubs2,
        instructions: Instruction.stubs2,
        imageURL: URL(string: "https://r2.vibe-cooking.app/images/default.png")
    )

    static let stubs: [Recipe] = [stub0, stub1, stub2]
}
