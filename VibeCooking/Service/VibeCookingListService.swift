//
//  VibeCookingListService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Foundation

final actor VibeCookingListService<Environment: EnvironmentProtocol> {
    func getRecipes() async throws -> [Components.Schemas.Recipe] {
        let recipeIDs: [String] = (try? await Environment.shared.localRepository.get(for: UserDefaultsKey.vibeCookingList)) ?? []
        return try await withThrowingTaskGroup(returning: [Components.Schemas.Recipe].self) { group in
            recipeIDs.forEach { id in
                group.addTask {
                    try await Environment.shared.recipeRepository.fetchRecipe(id: id)
                }
            }
            var recipes: [Components.Schemas.Recipe] = []
            for try await recipe in group {
                recipes.append(recipe)
            }
            return recipes
        }
    }

    func addRecipe(id: String) async throws {
        var recipeIDs: [String] = (try? await Environment.shared.localRepository.get(for: UserDefaultsKey.vibeCookingList)) ?? []
        guard !recipeIDs.contains(id) else { return }
        recipeIDs.append(id)
        try await Environment.shared.localRepository.set(recipeIDs, for: UserDefaultsKey.vibeCookingList)
    }

    func removeRecipe(id: String) async throws {
        var recipeIDs: [String] = (try? await Environment.shared.localRepository.get(for: UserDefaultsKey.vibeCookingList)) ?? []
        guard let index = recipeIDs.firstIndex(of: id) else { return }
        recipeIDs.remove(at: index)
        try await Environment.shared.localRepository.set(recipeIDs, for: UserDefaultsKey.vibeCookingList)
    }

    func clearRecipes() async throws {
        try await Environment.shared.localRepository.remove(for: UserDefaultsKey.vibeCookingList)
    }
}
