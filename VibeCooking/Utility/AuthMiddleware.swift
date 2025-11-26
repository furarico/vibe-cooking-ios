//
//  AuthMiddleware.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import FirebaseAppCheck
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
        let appCheckToken = try await AppCheck.appCheck().token(forcingRefresh: false)
        var request = request
        request.headerFields.append(
            .init(
                name: .init("X-Firebase-AppCheck")!, value: appCheckToken.token
            ))
        return try await next(request, body, baseURL)
    }
}
