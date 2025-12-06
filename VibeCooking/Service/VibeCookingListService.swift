//
//  VibeCookingListService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Dependencies
import Foundation

final actor VibeCookingListService {
    @Dependency(\.localRepository) private var localRepository
    @Dependency(\.recipeRepository) private var recipeRepository

    func getRecipes() async throws -> [Recipe] {
        let recipeIDs: [String] = (try? await localRepository.getVibeCookingList()) ?? []
        return try await recipeRepository.fetchRecipes(recipeIDs: recipeIDs, isVibeRecipe: nil)
    }

    func addRecipe(id: String) async throws {
        var recipeIDs: [String] = (try? await localRepository.getVibeCookingList()) ?? []
        guard !recipeIDs.contains(id) else { return }
        recipeIDs.append(id)
        try await localRepository.setVibeCookingList(recipeIDs)
    }

    func removeRecipe(id: String) async throws {
        var recipeIDs: [String] = (try? await localRepository.getVibeCookingList()) ?? []
        guard let index = recipeIDs.firstIndex(of: id) else { return }
        recipeIDs.remove(at: index)
        try await localRepository.setVibeCookingList(recipeIDs)
    }

    func clearRecipes() async throws {
        try await localRepository.removeVibeCookingList()
    }
}
