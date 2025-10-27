//
//  VibeCookingGlassButton.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/10/27.
//

import SwiftUI

@available(iOS 26.0, *)
struct VibeCookingGlassButton: View {
    private let label: String
    private let action: () -> Void

    init(
        _ label: String,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.action = action
    }

    var body: some View {
        Button(label, action: action)
            .buttonSizing(.flexible)
            .buttonStyle(.glassProminent)
            .controlSize(.large)
            .tint(.black)
    }
}

@available(iOS 26.0, *)
#Preview {
    VibeCookingGlassButton("ボタン") {
    }
    .padding()
}
