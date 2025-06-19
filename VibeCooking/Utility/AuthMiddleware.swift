//
//  AuthMiddleware.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

final actor AuthMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        let appCheckToken = try await AppCheckRepositoryImpl().getAppCheckToken()
        var request = request
        request.headerFields.append(
            .init(
                name: .init("X-Firebase-AppCheck")!, value: appCheckToken
            ))
        return try await next(request, body, baseURL)
    }
}
