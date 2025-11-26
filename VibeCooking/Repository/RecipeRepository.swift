//
//  RecipeRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Dependencies
import DependenciesMacros

@DependencyClient
struct RecipeRepository {
    var fetchRecipes: @Sendable (
        _ query: String?,
        _ category: String?,
        _ categoryID: String?,
        _ tags: [String]?
    ) async throws -> [Components.Schemas.Recipe]
    var fetchRecipe: @Sendable (_ id: String) async throws -> Components.Schemas.Recipe
    var fetchCategories: @Sendable () async throws -> [Components.Schemas.Category]
    var fetchVibeRecipe: @Sendable (_ recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe
}

extension RecipeRepository: DependencyKey {
    static let liveValue: RecipeRepository = RecipeRepository(
        fetchRecipes: { query, category, categoryID, tags in
            try await RecipeRepository.fetchRecipes(
                query: query,
                category: category,
                categoryID: categoryID,
                tags: tags
            )
        },
        fetchRecipe: { id in
            try await RecipeRepository.fetchRecipe(id: id)
        },
        fetchCategories: {
            try await RecipeRepository.fetchCategories()
        },
        fetchVibeRecipe: { recipeIDs in
            try await RecipeRepository.fetchVibeRecipe(recipeIDs: recipeIDs)
        }
    )

    private static func fetchRecipes(
        query: String?,
        category: String?,
        categoryID: String?,
        tags: [String]?
    ) async throws -> [Components.Schemas.Recipe] {
        do {
            let client = try await Client.build()
            let response = try await client.getRecipes(
                .init(
                    query: .init(
                        q: query,
                        tag: tags?.joined(separator: ","),
                        category: category,
                        categoryId: categoryID
                    )
                )
            )
            switch response {
            case .ok(let okResponse):
                if case let .json(body) = okResponse.body {
                    return body.recipes
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

    private static func fetchRecipe(id: String) async throws -> Components.Schemas.Recipe {
        do {
            let client = try await Client.build()
            let response = try await client.getRecipesId(path: .init(id: id))
            switch response {
            case .ok(let okResponse):
                if case let .json(value) = okResponse.body {
                    return value
                }
                throw RepositoryError.invalidResponseBody(okResponse.body)

            case .notFound:
                throw RepositoryError.server(.notFound, nil)

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

    private static func fetchCategories() async throws -> [Components.Schemas.Category] {
        do {
            let client = try await Client.build()
            let response = try await client.getCategories()
            switch response {
            case .ok(let okResponse):
                if case let .json(body) = okResponse.body {
                    return body.categories
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

    private static func fetchVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
        do {
            let client = try await Client.build()
            let response = try await client.postVibeRecipe(body: .json(.init(recipeIds: recipeIDs)))
            switch response {
            case .ok(let okResponse):
                if case let .json(value) = okResponse.body {
                    return value
                }
                throw RepositoryError.invalidResponseBody(okResponse.body)

            case .created(let okResponse):
                if case let .json(value) = okResponse.body {
                    return value
                }
                throw RepositoryError.invalidResponseBody(okResponse.body)

            case .badRequest:
                throw RepositoryError.server(.badRequest, nil)

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
}

extension DependencyValues {
    var recipeRepository: RecipeRepository {
        get { self[RecipeRepository.self] }
        set { self[RecipeRepository.self] = newValue }
    }
}
