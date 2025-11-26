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

    func getRecipes() async throws -> [Components.Schemas.Recipe] {
        try await recipeRepository.fetchRecipes(
            query: nil,
            category: nil,
            categoryID: nil,
            tags: nil
        )
    }

    func getRecipes(query: String) async throws -> [Components.Schemas.Recipe] {
        try await recipeRepository.fetchRecipes(
            query: query,
            category: nil,
            categoryID: nil,
            tags: nil
        )
    }

    func getRecipesByCategory(id: String) async throws -> [Components.Schemas.Recipe] {
        try await recipeRepository.fetchRecipes(
            query: nil,
            category: nil,
            categoryID: id,
            tags: nil
        )
    }

    func getRecipesByCategory(name: String) async throws -> [Components.Schemas.Recipe] {
        try await recipeRepository.fetchRecipes(
            query: nil,
            category: name,
            categoryID: nil,
            tags: nil
        )
    }

    func getRecipesByTags(_ tags: [String]) async throws -> [Components.Schemas.Recipe] {
        try await recipeRepository.fetchRecipes(
            query: nil,
            category: nil,
            categoryID: nil,
            tags: tags
        )
    }

    func getRecipe(id: String) async throws -> Components.Schemas.Recipe {
        try await recipeRepository.fetchRecipe(id: id)
    }

    func getCategories() async throws -> [Components.Schemas.Category] {
        try await recipeRepository.fetchCategories()
    }

    func getVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
        try await recipeRepository.fetchVibeRecipe(recipeIDs: recipeIDs)
    }
}
