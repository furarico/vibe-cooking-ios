//
//  Presenter.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Observation

@MainActor
protocol PresenterProtocol: Observable {
    associatedtype State: Equatable, Sendable

    associatedtype Action: Sendable

    var state: State { get set }

    func dispatch(_ action: Action) -> Void

    func dispatch(_ action: Action) async -> Void
}
