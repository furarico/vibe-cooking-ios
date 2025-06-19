//
//  DataState.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

enum DataState<V, E>: Equatable, Sendable where V : Equatable & Sendable, E : DomainErrorProtocol {
    case idle
    case loading
    case reloading(V)
    case retrying(E)
    case success(V)
    case failure(E)

    public var isLoading: Bool {
        switch self {
        case .loading, .reloading, .retrying:
            true
        default:
            false
        }
    }

    public var value: V? {
        switch self {
        case .reloading(let value), .success(let value):
            value
        default:
            nil
        }
    }

    public var error: E? {
        switch self {
        case .retrying(let error), .failure(let error):
            error
        default:
            nil
        }
    }
}
