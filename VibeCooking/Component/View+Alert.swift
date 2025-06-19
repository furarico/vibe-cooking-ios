//
//  View+Alert.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct AlertModifier<V, E, A>: ViewModifier where V : Equatable & Sendable, E : DomainErrorProtocol, A: View {
    @State private var isPresented = false

    private let state: DataState<V, E>
    private let actions: (String) -> A

    private var title: String {
        state.error?.title ?? ""
    }
    private var message: String? {
        state.error?.message
    }

    init(
        state: DataState<V, E>,
        @ViewBuilder actions: @escaping (String) -> A
    ) {
        self.state = state
        self.actions = actions
    }

    func body(content: Content) -> some View {
        content
            .alert(
                title,
                isPresented: $isPresented,
                presenting: message,
                actions: actions,
                message: Text.init
            )
            .onChange(of: state) { _, _ in
                switch state {
                case .failure:
                    isPresented = true
                default:
                    isPresented = false
                }
            }
    }
}

extension View {
    func alert<V, E>(
        _ state: DataState<V, E>
    ) -> some View {
        modifier(
            AlertModifier(
                state: state,
                actions: { _ in }
            )
        )
    }

    func alert<V, E>(
        _ state: DataState<V, E>,
        @ViewBuilder actions: @escaping (String) -> some View
    ) -> some View {
        modifier(
            AlertModifier(
                state: state,
                actions: actions
            )
        )
    }
}
