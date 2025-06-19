//
//  AppCheckRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import FirebaseAppCheck

protocol AppCheckRepositoryProtocol: Actor {
    func getAppCheckToken() async throws -> String
}

final actor AppCheckRepositoryImpl: AppCheckRepositoryProtocol {
    func getAppCheckToken() async throws -> String {
        let token = try await AppCheck.appCheck().token(forcingRefresh: false)
        return token.token
    }
}
