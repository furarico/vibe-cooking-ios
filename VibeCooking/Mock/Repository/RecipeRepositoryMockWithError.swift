//
//  RecipeRepositoryMockWithError.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/07/04.
//

final actor RecipeRepositoryMockWithError: RecipeRepositoryProtocol {
    func fetchRecipes(query: String?, category: String?, categoryID: String?, tags: [String]?) async throws -> [Components.Schemas.Recipe] {
        throw RepositoryError.server(.unauthorized, nil)
    }

    func fetchRecipe(id: String) async throws -> Components.Schemas.Recipe {
        throw RepositoryError.server(.unauthorized, nil)
    }

    func fetchCategories() async throws -> [Components.Schemas.Category] {
        throw RepositoryError.server(.unauthorized, nil)
    }

    func fetchVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
        throw RepositoryError.server(.unauthorized, nil)
    }
}
