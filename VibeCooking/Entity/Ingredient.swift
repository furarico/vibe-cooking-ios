//
//  Ingredient.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

struct Ingredient: Hashable, Identifiable {
    let id: String
    let name: String
    let amount: Double
    let unit: String
    let notes: String?
}

extension Ingredient {
    static let stub0 = Ingredient(
        id: "ingredient_001",
        name: "鶏もも肉",
        amount: 400,
        unit: "g",
        notes: "一口大に切る"
    )

    static let stub1 = Ingredient(
        id: "ingredient_002",
        name: "玉ねぎ",
        amount: 2,
        unit: "個",
        notes: "薄切りにする"
    )

    static let stub2 = Ingredient(
        id: "ingredient_003",
        name: "カレールー",
        amount: 1,
        unit: "箱",
        notes: nil
    )

    static let stub3 = Ingredient(
        id: "ingredient_004",
        name: "水",
        amount: 600,
        unit: "ml",
        notes: nil
    )

    static let stub4 = Ingredient(
        id: "ingredient_005",
        name: "スパゲッティ",
        amount: 200,
        unit: "g",
        notes: nil
    )

    static let stub5 = Ingredient(
        id: "ingredient_006",
        name: "牛ひき肉",
        amount: 300,
        unit: "g",
        notes: nil
    )

    static let stub6 = Ingredient(
        id: "ingredient_007",
        name: "トマト缶",
        amount: 1,
        unit: "缶",
        notes: "ホールトマト"
    )

    static let stub7 = Ingredient(
        id: "ingredient_008",
        name: "赤ワイン",
        amount: 100,
        unit: "ml",
        notes: nil
    )

    static let stub8 = Ingredient(
        id: "ingredient_009",
        name: "鶏もも肉",
        amount: 200,
        unit: "g",
        notes: "一口大に切る"
    )

    static let stub9 = Ingredient(
        id: "ingredient_010",
        name: "卵",
        amount: 4,
        unit: "個",
        notes: nil
    )

    static let stub10 = Ingredient(
        id: "ingredient_011",
        name: "玉ねぎ",
        amount: 1,
        unit: "個",
        notes: "薄切りにする"
    )

    static let stub11 = Ingredient(
        id: "ingredient_012",
        name: "ご飯",
        amount: 2,
        unit: "杯",
        notes: "温かいもの"
    )

    static let stubs0: [Ingredient] = [.stub0, .stub1, .stub2, .stub3]
    static let stubs1: [Ingredient] = [.stub4, .stub5, .stub6, .stub7]
    static let stubs2: [Ingredient] = [.stub8, .stub9, .stub10, .stub11]
}
