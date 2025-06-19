//
//  RecipeRepositoryMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

final actor RecipeRepositoryMock: RecipeRepositoryProtocol {
    func fetchRecipes(query: String?, category: String?, categoryID: String?, tags: [String]?) async throws -> [Components.Schemas.Recipe] {
        Components.Schemas.Recipe.stubs
    }
    
    func fetchRecipe(id: String) async throws -> Components.Schemas.Recipe {
        Components.Schemas.Recipe.stub0
    }
    
    func fetchCategories() async throws -> [Components.Schemas.Category] {
        Components.Schemas.Category.stubs
    }
    
    func fetchVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
        Components.Schemas.VibeRecipe.stub0
    }
}
