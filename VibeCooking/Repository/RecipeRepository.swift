//
//  RecipeRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
struct RecipeRepository {
    var fetchRecipes: @Sendable (_ recipeIDs: [String]?, _ isVibeRecipe: Bool?) async throws -> [Recipe]
}

extension RecipeRepository: DependencyKey {
    static let liveValue: RecipeRepository = RecipeRepository(
        fetchRecipes: { recipeIDs, isVibeRecipe in
            do {
                let client = try await Client.build()
                let response = try await client.getRecipes(
                    .init(
                        query: .init(
                            ids: recipeIDs,
                            isVibeRecipe: isVibeRecipe
                        )
                    )
                )
                switch response {
                case .ok(let okResponse):
                    if case let .json(value) = okResponse.body {
                        return value.recipes.map {
                            Recipe(
                                id: $0.id,
                                title: $0.title,
                                description: $0.description,
                                ingredients: $0.ingredients.map {
                                    Ingredient(
                                        id: $0.id,
                                        name: $0.name,
                                        amount: $0.amount,
                                        unit: $0.unit,
                                        notes: $0.notes
                                    )
                                },
                                instructions: $0.instructions.map {
                                    Instruction(
                                        id: $0.id,
                                        recipeID: $0.recipeId,
                                        step: $0.step,
                                        title: $0.title,
                                        description: $0.description,
                                        audioURL: $0.audioUrl.flatMap { URL(string: $0) },
                                        timerDuration: $0.timerDuration
                                    )
                                },
                                imageURL: $0.imageUrl.flatMap { URL(string: $0) }
                            )
                        }
                    }
                    throw RepositoryError.invalidResponseBody(okResponse.body)

                case .undocumented(let statusCode, let payload):
                    throw RepositoryError.server(.init(rawValue: statusCode), payload)
                }
            } catch let error as RepositoryError {
                Logger.error("RepositoryError: \(error.localizedDescription)")
                throw error
            } catch {
                Logger.error("RepositoryError: \(error)")
                throw error
            }
        }
    )
}

extension DependencyValues {
    var recipeRepository: RecipeRepository {
        get { self[RecipeRepository.self] }
        set { self[RecipeRepository.self] = newValue }
    }
}
