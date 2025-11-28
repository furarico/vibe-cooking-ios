//
//  ComponentsSchemasInstruction+Stub.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

extension Components.Schemas.Instruction {
    static let stub0: Components.Schemas.Instruction = .init(
        id: "instruction_001",
        recipeId: "recipe_001",
        step: 1,
        title: "材料を準備する",
        description: "鶏もも肉を一口大に切り、玉ねぎを薄切りにします。",
        imageUrl: nil,
        audioUrl: nil,
        estimatedTime: 10,
        timerDuration: "00:05:00"
    )

    static let stub1: Components.Schemas.Instruction = .init(
        id: "instruction_002",
        recipeId: "recipe_001",
        step: 2,
        title: "炒める",
        description: "フライパンで鶏肉と玉ねぎを炒めます。",
        imageUrl: nil,
        audioUrl: nil,
        estimatedTime: 10
    )

    static let stub2: Components.Schemas.Instruction = .init(
        id: "instruction_003",
        recipeId: "recipe_001",
        step: 3,
        title: "煮込む",
        description: "水を加えて煮込み、カレールーを溶かします。",
        imageUrl: nil,
        audioUrl: nil,
        estimatedTime: 20
    )

    static let stub3: Components.Schemas.Instruction = .init(
            id: "instruction_004",
            recipeId: "recipe_002",
            step: 1,
            title: "ひき肉を炒める",
            description: "フライパンで牛ひき肉をしっかりと炒めます。",
            imageUrl: nil,
            audioUrl: nil,
            estimatedTime: 10
        )

    static let stub4: Components.Schemas.Instruction = .init(
            id: "instruction_005",
            recipeId: "recipe_002",
            step: 2,
            title: "ソースを作る",
            description: "トマト缶と赤ワインを加えて煮込みます。",
            imageUrl: nil,
            audioUrl: nil,
            estimatedTime: 25
        )

    static let stub5: Components.Schemas.Instruction = .init(
            id: "instruction_006",
            recipeId: "recipe_002",
            step: 3,
            title: "パスタと合わせる",
            description: "茹でたパスタとソースを絡めます。",
            imageUrl: nil,
            audioUrl: nil,
            estimatedTime: 5
        )

    static let stub6: Components.Schemas.Instruction = .init(
            id: "instruction_007",
            recipeId: "recipe_003",
            step: 1,
            title: "具材を煮る",
            description: "鶏肉と玉ねぎを出汁で煮ます。",
            imageUrl: nil,
            audioUrl: nil,
            estimatedTime: 8
        )

    static let stub7: Components.Schemas.Instruction = .init(
            id: "instruction_008",
            recipeId: "recipe_003",
            step: 2,
            title: "卵を加える",
            description: "溶き卵を回し入れて半熟状にします。",
            imageUrl: nil,
            audioUrl: nil,
            estimatedTime: 5
        )

    static let stub8: Components.Schemas.Instruction = .init(
            id: "instruction_009",
            recipeId: "recipe_003",
            step: 3,
            title: "ご飯にのせる",
            description: "温かいご飯の上にのせて完成です。",
            imageUrl: nil,
            audioUrl: nil,
            estimatedTime: 2
        )

    static let stubs0: [Components.Schemas.Instruction] = [stub0, stub1, stub2]
    static let stubs1: [Components.Schemas.Instruction] = [stub3, stub4, stub5]
    static let stubs2: [Components.Schemas.Instruction] = [stub6, stub7, stub8]
}
