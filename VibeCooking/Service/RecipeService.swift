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

    func getRecipes() async throws -> [Recipe] {
        try await recipeRepository.fetchRecipes()
    }

    func getRecipe(id: String) async throws -> Recipe {
        try await recipeRepository.fetchRecipe(id: id)
    }

    func getVibeRecipe(recipeIDs: [String]) async throws -> [Recipe] {
        try await recipeRepository.fetchVibeRecipe(recipeIDs: recipeIDs)
    }
}
