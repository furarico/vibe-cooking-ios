//
//  DomainErrorProtocol.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

public protocol DomainErrorProtocol: Error, Equatable, Sendable {
    var title: String { get }
    var message: String { get }
}

enum DomainError: DomainErrorProtocol {
    static func == (lhs: DomainError, rhs: DomainError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            true
        default:
            lhs == rhs
        }
    }

    case custom(title: String, message: String)
    case service(ServiceError)
    case repository(RepositoryError)
    case unknown(Error)

    init(_ error: Error) {
        if let error = error as? ServiceError {
            self = .service(error)
        }
        if let error = error as? RepositoryError {
            self = .repository(error)
        }
        self = .unknown(error)
    }

    var errorDescription: String? {
        switch self {
        case .custom(let title, let message):
            "\(title): \(message)"
        case .service(let error):
            error.localizedDescription
        case .repository(let error):
            error.localizedDescription
        case .unknown(let error):
            error.localizedDescription
        }
    }

    var title: String {
        switch self {
        case .custom(let title, _):
            title
        case .service:
            "Service Error"
        case .repository:
            "Repository Error"
        case .unknown:
            "Something went wrong"
        }
    }

    var message: String {
        switch self {
        case .custom(_, let message):
            message
        case .service(let error):
            error.localizedDescription
        case .repository(let error):
            error.localizedDescription
        case .unknown:
            "Unexpected error occurred."
        }
    }
}
