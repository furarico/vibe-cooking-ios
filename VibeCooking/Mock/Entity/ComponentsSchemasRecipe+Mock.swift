//
//  ComponentsSchemasRecipe+Mock.swift
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
        category: .init(
            id: "category_001",
            name: "カレー"
        ),
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        ingredients: [
            .init(
                id: "ingredient_001",
                name: "鶏もも肉",
                amount: 400,
                unit: "g",
                notes: "一口大に切る"
            ),
            .init(
                id: "ingredient_002",
                name: "玉ねぎ",
                amount: 2,
                unit: "個",
                notes: "薄切りにする"
            ),
            .init(
                id: "ingredient_003",
                name: "カレールー",
                amount: 1,
                unit: "箱",
                notes: nil
            ),
            .init(
                id: "ingredient_004",
                name: "水",
                amount: 600,
                unit: "ml",
                notes: nil
            )
        ],
        instructions: [
            .init(
                id: "instruction_001",
                recipeId: "recipe_001",
                step: 1,
                title: "材料を準備する",
                description: "鶏もも肉を一口大に切り、玉ねぎを薄切りにします。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 10
            ),
            .init(
                id: "instruction_002",
                recipeId: "recipe_001",
                step: 2,
                title: "炒める",
                description: "フライパンで鶏肉と玉ねぎを炒めます。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 10
            ),
            .init(
                id: "instruction_003",
                recipeId: "recipe_001",
                step: 3,
                title: "煮込む",
                description: "水を加えて煮込み、カレールーを溶かします。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 20
            )
        ],
        imageUrl: "https://example.com/images/chicken-curry.jpg",
        tags: ["カレー", "チキン", "スパイシー"],
        createdAt: Date(timeIntervalSince1970: 1704067200), // 2024-01-01
        updatedAt: Date(timeIntervalSince1970: 1704067200) // 2024-01-01
    )
    
    static let stub1: Components.Schemas.Recipe = .init(
        id: "recipe_002",
        title: "パスタボロネーゼ",
        description: "本格的なボロネーゼソースで作るパスタです。",
        category: .init(
            id: "category_002",
            name: "パスタ"
        ),
        prepTime: 20,
        cookTime: 40,
        servings: 2,
        ingredients: [
            .init(
                id: "ingredient_005",
                name: "スパゲッティ",
                amount: 200,
                unit: "g",
                notes: nil
            ),
            .init(
                id: "ingredient_006",
                name: "牛ひき肉",
                amount: 300,
                unit: "g",
                notes: nil
            ),
            .init(
                id: "ingredient_007",
                name: "トマト缶",
                amount: 1,
                unit: "缶",
                notes: "ホールトマト"
            ),
            .init(
                id: "ingredient_008",
                name: "赤ワイン",
                amount: 100,
                unit: "ml",
                notes: nil
            )
        ],
        instructions: [
            .init(
                id: "instruction_004",
                recipeId: "recipe_002",
                step: 1,
                title: "ひき肉を炒める",
                description: "フライパンで牛ひき肉をしっかりと炒めます。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 10
            ),
            .init(
                id: "instruction_005",
                recipeId: "recipe_002",
                step: 2,
                title: "ソースを作る",
                description: "トマト缶と赤ワインを加えて煮込みます。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 25
            ),
            .init(
                id: "instruction_006",
                recipeId: "recipe_002",
                step: 3,
                title: "パスタと合わせる",
                description: "茹でたパスタとソースを絡めます。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 5
            )
        ],
        imageUrl: "https://example.com/images/pasta-bolognese.jpg",
        tags: ["パスタ", "ボロネーゼ", "イタリアン"],
        createdAt: Date(timeIntervalSince1970: 1704153600), // 2024-01-02
        updatedAt: Date(timeIntervalSince1970: 1704153600) // 2024-01-02
    )
    
    static let stub2: Components.Schemas.Recipe = .init(
        id: "recipe_003",
        title: "親子丼",
        description: "ふわふわ卵の親子丼です。お手軽に作れる定番料理。",
        category: .init(
            id: "category_003",
            name: "丼もの"
        ),
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        ingredients: [
            .init(
                id: "ingredient_009",
                name: "鶏もも肉",
                amount: 200,
                unit: "g",
                notes: "一口大に切る"
            ),
            .init(
                id: "ingredient_010",
                name: "卵",
                amount: 4,
                unit: "個",
                notes: nil
            ),
            .init(
                id: "ingredient_011",
                name: "玉ねぎ",
                amount: 1,
                unit: "個",
                notes: "薄切りにする"
            ),
            .init(
                id: "ingredient_012",
                name: "ご飯",
                amount: 2,
                unit: "杯",
                notes: "温かいもの"
            )
        ],
        instructions: [
            .init(
                id: "instruction_007",
                recipeId: "recipe_003",
                step: 1,
                title: "具材を煮る",
                description: "鶏肉と玉ねぎを出汁で煮ます。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 8
            ),
            .init(
                id: "instruction_008",
                recipeId: "recipe_003",
                step: 2,
                title: "卵を加える",
                description: "溶き卵を回し入れて半熟状にします。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 5
            ),
            .init(
                id: "instruction_009",
                recipeId: "recipe_003",
                step: 3,
                title: "ご飯にのせる",
                description: "温かいご飯の上にのせて完成です。",
                imageUrl: nil,
                audioUrl: nil,
                estimatedTime: 2
            )
        ],
        imageUrl: "https://example.com/images/oyakodon.jpg",
        tags: ["丼もの", "和食", "簡単"],
        createdAt: Date(timeIntervalSince1970: 1704240000), // 2024-01-03
        updatedAt: Date(timeIntervalSince1970: 1704240000) // 2024-01-03
    )
    
    static let stubs: [Components.Schemas.Recipe] = [stub0, stub1, stub2]
}
