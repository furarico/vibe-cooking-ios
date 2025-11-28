//
//  Instruction.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

struct Instruction: Hashable, Identifiable {
    let id: String
    let recipeID: String
    let step: Int
    let title: String
    let description: String
    let audioURL: URL?
    let timerDuration: TimeInterval?
}

extension Instruction {
    static let stub0 = Instruction(
        id: "instruction_001",
        recipeID: "recipe_001",
        step: 1,
        title: "材料を準備する",
        description: "鶏もも肉を一口大に切り、玉ねぎを薄切りにします。",
        audioURL: nil,
        timerDuration: 300
    )

    static let stub1 = Instruction(
        id: "instruction_002",
        recipeID: "recipe_001",
        step: 2,
        title: "炒める",
        description: "フライパンで鶏肉と玉ねぎを炒めます。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub2 = Instruction(
        id: "instruction_003",
        recipeID: "recipe_001",
        step: 3,
        title: "煮込む",
        description: "水を加えて煮込み、カレールーを溶かします。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub3 = Instruction(
        id: "instruction_004",
        recipeID: "recipe_002",
        step: 1,
        title: "ひき肉を炒める",
        description: "フライパンで牛ひき肉をしっかりと炒めます。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub4 = Instruction(
        id: "instruction_005",
        recipeID: "recipe_002",
        step: 2,
        title: "ソースを作る",
        description: "トマト缶と赤ワインを加えて煮込みます。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub5 = Instruction(
        id: "instruction_006",
        recipeID: "recipe_002",
        step: 3,
        title: "パスタと合わせる",
        description: "茹でたパスタとソースを絡めます。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub6 = Instruction(
        id: "instruction_007",
        recipeID: "recipe_003",
        step: 1,
        title: "具材を煮る",
        description: "鶏肉と玉ねぎを出汁で煮ます。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub7 = Instruction(
        id: "instruction_008",
        recipeID: "recipe_003",
        step: 2,
        title: "卵を加える",
        description: "溶き卵を回し入れて半熟状にします。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stub8 = Instruction(
        id: "instruction_009",
        recipeID: "recipe_003",
        step: 3,
        title: "ご飯にのせる",
        description: "温かいご飯の上にのせて完成です。",
        audioURL: nil,
        timerDuration: nil
    )

    static let stubs0: [Instruction] = [stub0, stub1, stub2]
    static let stubs1: [Instruction] = [stub3, stub4, stub5]
    static let stubs2: [Instruction] = [stub6, stub7, stub8]
}
