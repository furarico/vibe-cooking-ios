//
//  LocalRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/26.
//

import Dependencies
import DependenciesMacros

@DependencyClient
struct LocalRepository {
    var getVibeCookingList: @Sendable () async throws -> [String]
    var setVibeCookingList: @Sendable (_ recipeIDs: [String]) async throws -> Void
    var removeVibeCookingList: @Sendable () async throws -> Void
}

extension LocalRepository: DependencyKey {
    static let liveValue: LocalRepository = LocalRepository(
        getVibeCookingList: {
            try await UserDefaultsHelper.shared.get(for: UserDefaultsKey.vibeCookingList)
        },
        setVibeCookingList: { recipeIDs in
            try await UserDefaultsHelper.shared.set(recipeIDs, for: UserDefaultsKey.vibeCookingList)
        },
        removeVibeCookingList: {
            try await UserDefaultsHelper.shared.remove(for: UserDefaultsKey.vibeCookingList)
        }
    )
}

extension DependencyValues {
    var localRepository: LocalRepository {
        get { self[LocalRepository.self] }
        set { self[LocalRepository.self] = newValue }
    }
}
