//
//  AppCheckRepositoyMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

final actor AppCheckRepositoryMock: AppCheckRepositoryProtocol {
    func getAppCheckToken() async throws -> String {
        ""
    }
}
