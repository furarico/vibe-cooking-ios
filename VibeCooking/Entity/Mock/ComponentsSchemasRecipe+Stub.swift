//
//  ComponentsSchemasRecipe+Stub.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

extension Components.Schemas.Recipe {
    static let stub0: Components.Schemas.Recipe = .init(
        id: "recipe_001",
        title: "チキンカレー",
        description: "スパイシーで美味しいチキンカレーです。家庭で簡単に作れます。",
        category: .stub0,
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        ingredients: Components.Schemas.Ingredient.stubs0,
        instructions: Components.Schemas.Instruction.stubs0,
        imageUrl: "https://r2.vibe-cooking.app/images/default.png",
        tags: ["カレー", "チキン", "スパイシー"],
        createdAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01
        updatedAt: Date(timeIntervalSince1970: 1704067200) // 2024-01-01
    )
    
    static let stub1: Components.Schemas.Recipe = .init(
        id: "recipe_002",
        title: "パスタボロネーゼ",
        description: "本格的なボロネーゼソースで作るパスタです。",
        category: .stub1,
        prepTime: 20,
        cookTime: 40,
        servings: 2,
        ingredients: Components.Schemas.Ingredient.stubs1,
        instructions: Components.Schemas.Instruction.stubs1,
        imageUrl: "https://r2.vibe-cooking.app/images/default.png",
        tags: ["パスタ", "ボロネーゼ", "イタリアン"],
        createdAt: Date(timeIntervalSince1970: 1704153600), // 2024-01-02
        updatedAt: Date(timeIntervalSince1970: 1704153600) // 2024-01-02
    )
    
    static let stub2: Components.Schemas.Recipe = .init(
        id: "recipe_003",
        title: "親子丼",
        description: "ふわふわ卵の親子丼です。お手軽に作れる定番料理。",
        category: .stub2,
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        ingredients: Components.Schemas.Ingredient.stubs2,
        instructions: Components.Schemas.Instruction.stubs2,
        imageUrl: "https://r2.vibe-cooking.app/images/default.png",
        tags: ["丼もの", "和食", "簡単"],
        createdAt: Date(timeIntervalSince1970: 1704240000), // 2024-01-03
        updatedAt: Date(timeIntervalSince1970: 1704240000) // 2024-01-03
    )
    
    static let stubs: [Components.Schemas.Recipe] = [stub0, stub1, stub2]
}
