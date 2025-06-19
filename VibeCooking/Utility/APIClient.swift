//
//  APIClient.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import OpenAPIURLSession

extension Client {
    static func build() async throws -> Client {
        return Client(
            serverURL: try Servers.Server1.url(),
            configuration: .init(dateTranscoder: .iso8601WithFractionalSeconds),
            transport: URLSessionTransport(),
            middlewares: [AuthMiddleware()]
        )
    }
}
