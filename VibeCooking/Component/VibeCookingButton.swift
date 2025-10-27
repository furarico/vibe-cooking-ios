//
//  VibeCookingButton.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/21.
//

import SwiftUI

struct VibeCookingButton: View {
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
        if #available(iOS 26.0, *) {
            VibeCookingGlassButton(label, action: action)
        } else {
            VibeCookingFlatButton(label, action: action)
        }
    }
}

#Preview {
    VibeCookingButton("ボタン") {
    }
    .padding()
}

@available(iOS 26.0, *)
#Preview {
    VStack {
        VibeCookingGlassButton("ボタン") {
        }

        VibeCookingFlatButton("ボタン") {
        }
    }
    .padding()
}
