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

public enum DomainError: DomainErrorProtocol {
    public static func == (lhs: DomainError, rhs: DomainError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            true
        default:
            lhs == rhs
        }
    }

    case network
    case unknown(Error)

    public init(_ error: Error) {
        self = .unknown(error)
    }

    public var errorDescription: String? {
        switch self {
        case .network:
            "Network Error"
        case .unknown(let error):
            error.localizedDescription
        }
    }

    public var title: String {
        switch self {
        case .network:
            "Network Error"
        case .unknown:
            "Something went wrong"
        }
    }

    public var message: String {
        switch self {
        case .network:
            "Please check your network connection."
        case .unknown:
            "Unexpected error occurred."
        }
    }
}
