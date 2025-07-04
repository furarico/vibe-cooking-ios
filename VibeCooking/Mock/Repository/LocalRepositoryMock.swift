//
//  LocalRepositoryMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Foundation

final actor LocalRepositoryMock: LocalRepositoryProtocol {
    func get<T: Codable & Sendable>(for key: String) async throws -> T {
        return try JSONDecoder().decode(T.self, from: Data())
    }
    
    func set<T: Codable & Sendable>(_ value: T, for key: String) async throws {
    }
    
    func remove(for key: String) async throws {
    }
}
