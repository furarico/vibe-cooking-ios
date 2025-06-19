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
                instructionId: "instruction_001",
                step: 1,
                recipeId: "recipe_001"
            ),
            .init(
                instructionId: "instruction_004",
                step: 2,
                recipeId: "recipe_002"
            ),
            .init(
                instructionId: "instruction_002",
                step: 3,
                recipeId: "recipe_001"
            ),
            .init(
                instructionId: "instruction_005",
                step: 4,
                recipeId: "recipe_002"
            ),
            .init(
                instructionId: "instruction_003",
                step: 5,
                recipeId: "recipe_001"
            ),
            .init(
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
                instructionId: "instruction_004",
                step: 1,
                recipeId: "recipe_002"
            ),
            .init(
                instructionId: "instruction_007",
                step: 2,
                recipeId: "recipe_003"
            ),
            .init(
                instructionId: "instruction_005",
                step: 3,
                recipeId: "recipe_002"
            ),
            .init(
                instructionId: "instruction_008",
                step: 4,
                recipeId: "recipe_003"
            ),
            .init(
                instructionId: "instruction_006",
                step: 5,
                recipeId: "recipe_002"
            ),
            .init(
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
                instructionId: "instruction_001",
                step: 1,
                recipeId: "recipe_001"
            ),
            .init(
                instructionId: "instruction_007",
                step: 2,
                recipeId: "recipe_003"
            ),
            .init(
                instructionId: "instruction_002",
                step: 3,
                recipeId: "recipe_001"
            ),
            .init(
                instructionId: "instruction_008",
                step: 4,
                recipeId: "recipe_003"
            ),
            .init(
                instructionId: "instruction_003",
                step: 5,
                recipeId: "recipe_001"
            ),
            .init(
                instructionId: "instruction_009",
                step: 6,
                recipeId: "recipe_003"
            )
        ]
    )
    
    static let stubs: [Components.Schemas.VibeRecipe] = [stub0, stub1, stub2]
}
