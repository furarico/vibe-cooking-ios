//
//  RecipeRepositoryMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

final actor RecipeRepositoryMock: RecipeRepositoryProtocol {
    func fetchRecipes(query: String?, category: String?, categoryID: String?, tags: [String]?) async throws -> [Components.Schemas.Recipe] {
        []
    }
    
    func fetchRecipe(id: String) async throws -> Components.Schemas.Recipe {
        .init()
    }
    
    func fetchCategories() async throws -> [Components.Schemas.Category] {
        []
    }
    
    func fetchVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
        .init(id: "", recipeIds: [], vibeInstructions: [])
    }
}
