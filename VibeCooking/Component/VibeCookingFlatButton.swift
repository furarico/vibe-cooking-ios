//
//  VibeCookingFlatButton.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/10/27.
//

import SwiftUI

struct VibeCookingFlatButton: View {
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
        Button(action: action) {
            Text(label)
                .font(.caption)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.black)
    }
}

#Preview {
    VibeCookingFlatButton("ボタン") {
    }
    .padding()
}
