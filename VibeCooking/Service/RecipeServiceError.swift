//
//  RecipeServiceError.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/12/06.
//

import Foundation

enum RecipeServiceError: LocalizedError {
    case recipeNotFound(_ id: String)

    var errorDescription: String? {
        switch self {
        case .recipeNotFound(let id):
            return "Recipe with ID \(id) was not found."
        }
    }
}
