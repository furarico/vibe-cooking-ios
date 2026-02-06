//
//  RecipeService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Dependencies
import Foundation

final actor RecipeService {
    @Dependency(\.recipeRepository) private var recipeRepository

    func getRecipes(recipeIDs: [String]? = nil) async throws -> [Recipe] {
        try await recipeRepository.fetchRecipes(recipeIDs: recipeIDs, isVibeRecipe: nil)
    }

    func getRecipe(id: String) async throws -> Recipe {
        let recipes = try await recipeRepository.fetchRecipes(recipeIDs: [id], isVibeRecipe: false)
        guard let recipe = recipes.first else {
            throw ServiceError.recipe(.recipeNotFound(id))
        }
        return recipe
    }

    func getVibeRecipe(recipeIDs: [String]) async throws -> [Recipe] {
        try await recipeRepository.fetchRecipes(recipeIDs: recipeIDs, isVibeRecipe: true)
    }
}
