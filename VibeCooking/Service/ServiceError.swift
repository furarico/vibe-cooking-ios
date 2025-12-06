//
//  ServiceError.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

enum ServiceError: LocalizedError {
    case recipe(RecipeServiceError)

    var errorDescription: String? {
        switch self {
        case .recipe(let error):
            return error.localizedDescription
        }
    }
}
