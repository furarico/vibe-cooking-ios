//
//  RecipeService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

final actor RecipeService<Environment: EnvironmentProtocol> {
    func getRecipes() async throws -> [Components.Schemas.Recipe] {
        try await Environment.shared.recipeRepository.fetchRecipes(
            query: nil,
            category: nil,
            categoryID: nil,
            tags: nil
        )
    }

    func getRecipes(query: String) async throws -> [Components.Schemas.Recipe] {
        try await Environment.shared.recipeRepository.fetchRecipes(
            query: query,
            category: nil,
            categoryID: nil,
            tags: nil
        )
    }

    func getRecipesByCategory(id: String) async throws -> [Components.Schemas.Recipe] {
        try await Environment.shared.recipeRepository.fetchRecipes(
            query: nil,
            category: nil,
            categoryID: id,
            tags: nil
        )
    }

    func getRecipesByCategory(name: String) async throws -> [Components.Schemas.Recipe] {
        try await Environment.shared.recipeRepository.fetchRecipes(
            query: nil,
            category: name,
            categoryID: nil,
            tags: nil
        )
    }

    func getRecipesByTags(_ tags: [String]) async throws -> [Components.Schemas.Recipe] {
        try await Environment.shared.recipeRepository.fetchRecipes(
            query: nil,
            category: nil,
            categoryID: nil,
            tags: tags
        )
    }

    func getRecipe(id: String) async throws -> Components.Schemas.Recipe {
        try await Environment.shared.recipeRepository.fetchRecipe(id: id)
    }

    func getCategories() async throws -> [Components.Schemas.Category] {
        try await Environment.shared.recipeRepository.fetchCategories()
    }

    func getVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
        try await Environment.shared.recipeRepository.fetchVibeRecipe(recipeIDs: recipeIDs)
    }
}
