//
//  LocalRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import Foundation

protocol LocalRepositoryProtocol {
    func get<T: Codable>(for key: String) async throws -> T

    func set<T: Codable>(_ value: T, for key: String) async throws

    func remove(for key: String) async throws
}

final class LocalRepositoryImpl: LocalRepositoryProtocol {
    private let userDefaults: UserDefaults

    init() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            self.userDefaults = .init(suiteName: "group.\(bundleIdentifier)") ?? .standard
        } else {
            self.userDefaults = .standard
        }
    }

    func get<T: Codable>(for key: String) async throws -> T {
        guard let data = userDefaults.data(forKey: key) else {
            throw LocalRepositoryError.notFound
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func set<T: Codable>(_ value: T, for key: String) async throws {
        let data = try JSONEncoder().encode(value)
        userDefaults.set(data, forKey: key)
    }

    func remove(for key: String) async throws {
        userDefaults.removeObject(forKey: key)
    }
}
