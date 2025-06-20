//
//  ComponentsSchemasVibeRecipe.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

extension Components.Schemas.VibeRecipe {
    static let stub0: Components.Schemas.VibeRecipe = .init(
        id: "vibe_recipe_001",
        recipeIds: ["recipe_001", "recipe_002"],
        vibeInstructions: [
            .init(
                id: "vibe_instruction_001",
                instructionId: "instruction_001",
                step: 1,
                recipeId: "recipe_001"
            ),
            .init(
                id: "vibe_instruction_002",
                instructionId: "instruction_004",
                step: 2,
                recipeId: "recipe_002"
            ),
            .init(
                id: "vibe_instruction_003",
                instructionId: "instruction_002",
                step: 3,
                recipeId: "recipe_001"
            ),
            .init(
                id: "vibe_instruction_004",
                instructionId: "instruction_005",
                step: 4,
                recipeId: "recipe_002"
            ),
            .init(
                id: "vibe_instruction_005",
                instructionId: "instruction_003",
                step: 5,
                recipeId: "recipe_001"
            ),
            .init(
                id: "vibe_instruction_006",
                instructionId: "instruction_006",
                step: 6,
                recipeId: "recipe_002"
            )
        ]
    )
    
    static let stub1: Components.Schemas.VibeRecipe = .init(
        id: "vibe_recipe_002",
        recipeIds: ["recipe_002", "recipe_003"],
        vibeInstructions: [
            .init(
                id: "vibe_instruction_007",
                instructionId: "instruction_004",
                step: 1,
                recipeId: "recipe_002"
            ),
            .init(
                id: "vibe_instruction_008",
                instructionId: "instruction_007",
                step: 2,
                recipeId: "recipe_003"
            ),
            .init(
                id: "vibe_instruction_009",
                instructionId: "instruction_005",
                step: 3,
                recipeId: "recipe_002"
            ),
            .init(
                id: "vibe_instruction_010",
                instructionId: "instruction_008",
                step: 4,
                recipeId: "recipe_003"
            ),
            .init(
                id: "vibe_instruction_011",
                instructionId: "instruction_006",
                step: 5,
                recipeId: "recipe_002"
            ),
            .init(
                id: "vibe_instruction_012",
                instructionId: "instruction_009",
                step: 6,
                recipeId: "recipe_003"
            )
        ]
    )
    
    static let stub2: Components.Schemas.VibeRecipe = .init(
        id: "vibe_recipe_003",
        recipeIds: ["recipe_001", "recipe_003"],
        vibeInstructions: [
            .init(
                id: "vibe_instruction_013",
                instructionId: "instruction_001",
                step: 1,
                recipeId: "recipe_001"
            ),
            .init(
                id: "vibe_instruction_014",
                instructionId: "instruction_007",
                step: 2,
                recipeId: "recipe_003"
            ),
            .init(
                id: "vibe_instruction_015",
                instructionId: "instruction_002",
                step: 3,
                recipeId: "recipe_001"
            ),
            .init(
                id: "vibe_instruction_016",
                instructionId: "instruction_008",
                step: 4,
                recipeId: "recipe_003"
            ),
            .init(
                id: "vibe_instruction_017",
                instructionId: "instruction_003",
                step: 5,
                recipeId: "recipe_001"
            ),
            .init(
                id: "vibe_instruction_018",
                instructionId: "instruction_009",
                step: 6,
                recipeId: "recipe_003"
            )
        ]
    )
    
    static let stubs: [Components.Schemas.VibeRecipe] = [stub0, stub1, stub2]
}
