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
    var fetchRecipes: @Sendable () async throws -> [Recipe]
    var fetchRecipe: @Sendable (_ id: String) async throws -> Recipe
    var fetchVibeRecipe: @Sendable (_ recipeIDs: [String]) async throws -> VibeRecipe
}

extension RecipeRepository: DependencyKey {
    static let liveValue: RecipeRepository = RecipeRepository(
        fetchRecipes: {
            try await RecipeRepository.fetchRecipes()
        },
        fetchRecipe: { id in
            try await RecipeRepository.fetchRecipe(id: id)
        },
        fetchVibeRecipe: { recipeIDs in
            try await RecipeRepository.fetchVibeRecipe(recipeIDs: recipeIDs)
        }
    )

    private static func fetchRecipes(
        query: String? = nil,
        category: String? = nil,
        categoryID: String? = nil,
        tags: [String]? = nil
    ) async throws -> [Recipe] {
        do {
            let client = try await Client.build()
            let response = try await client.getRecipes()
            switch response {
            case .ok(let okResponse):
                if case let .json(body) = okResponse.body {
                    let apiRecipes = body.recipes
                    return apiRecipes.map {
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

    private static func fetchRecipe(id: String) async throws -> Recipe {
        do {
            let client = try await Client.build()
            let response = try await client.getRecipes(
                .init(
                    query: .init(
                        ids: [id]
                    )
                )
            )
            switch response {
            case .ok(let okResponse):
                if case let .json(value) = okResponse.body {
                    guard let recipe = value.recipes.first else {
                        throw RepositoryError.invalidResponseBody(okResponse.body)
                    }
                    return Recipe(
                        id: recipe.id,
                        title: recipe.title,
                        description: recipe.description,
                        ingredients: recipe.ingredients.map {
                            Ingredient(
                                id: $0.id,
                                name: $0.name,
                                amount: $0.amount,
                                unit: $0.unit,
                                notes: $0.notes
                            )
                        },
                        instructions: recipe.instructions.map {
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
                        imageURL: recipe.imageUrl.flatMap { URL(string: $0) }
                    )
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

    private static func fetchVibeRecipe(recipeIDs: [String]) async throws -> VibeRecipe {
        do {
            let client = try await Client.build()
            let response = try await client.getRecipes(
                .init(
                    query: .init(
                        ids: recipeIDs,
                        isVibeRecipe: true
                    )
                )
            )
            switch response {
            case .ok(let okResponse):
                if case let .json(value) = okResponse.body {
                    return try await translateToVibeRecipe(from: value.recipes)
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

    private static func translateToVibeRecipe(from recipes: [Components.Schemas.Recipe]) async throws -> VibeRecipe {
        return VibeRecipe(
            recipes: recipes.map {
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
            },
            instructions: recipes.flatMap {
                $0.instructions
            }.map {
                Instruction(
                    id: $0.id,
                    recipeID: $0.recipeId,
                    step: $0.step,
                    title: $0.title,
                    description: $0.description,
                    audioURL: $0.audioUrl.flatMap { URL(string: $0) },
                    timerDuration: $0.timerDuration
                )
            }.sorted { $0.step < $1.step }
        )
    }
}

extension DependencyValues {
    var recipeRepository: RecipeRepository {
        get { self[RecipeRepository.self] }
        set { self[RecipeRepository.self] = newValue }
    }
}
