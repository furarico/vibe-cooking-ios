//
//  LocalRepositoryMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Foundation

final actor LocalRepositoryMock: LocalRepositoryProtocol {
    func get<T>(for key: String) async throws -> T where T : Decodable, T : Encodable {
        return try JSONDecoder().decode(T.self, from: Data())
    }
    
    func set<T>(_ value: T, for key: String) async throws where T : Decodable, T : Encodable {
    }
    
    func remove(for key: String) async throws {
    }
}
