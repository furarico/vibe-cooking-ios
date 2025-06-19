//
//  RecipeRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

protocol RecipeRepositoryProtocol: Actor {
    func fetchRecipes(
        query: String?,
        category: String?,
        categoryID: String?,
        tags: [String]?
    ) async throws -> [Components.Schemas.Recipe]

    func fetchRecipe(id: String) async throws -> Components.Schemas.Recipe

    func fetchCategories() async throws -> [Components.Schemas.Category]

    func fetchVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe
}

final actor RecipeRepositoryImpl: RecipeRepositoryProtocol {
    func fetchRecipes(
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
                if case let .json(body) = okResponse.body,
                   let value = body.recipes {
                    return value
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

    func fetchRecipe(id: String) async throws -> Components.Schemas.Recipe {
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

    func fetchCategories() async throws -> [Components.Schemas.Category] {
        do {
            let client = try await Client.build()
            let response = try await client.getCategories()
            switch response {
            case .ok(let okResponse):
                if case let .json(body) = okResponse.body,
                   let value = body.categories {
                    return value
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

    func fetchVibeRecipe(recipeIDs: [String]) async throws -> Components.Schemas.VibeRecipe {
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
