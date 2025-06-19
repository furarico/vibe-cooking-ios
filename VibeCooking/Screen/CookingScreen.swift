//
//  CookingScreen.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct CookingScreen<Environment: EnvironmentProtocol>: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @State private var presenter: CookingPresenter<Environment>

    init(recipe: Components.Schemas.Recipe) {
        presenter = .init(recipe: recipe)
    }

    var body: some View {
        Text(presenter.state.recipe.title ?? "")
        Button("終了") {
            dismiss()
        }
    }
}

#Preview {
    CookingScreen<MockEnvironment>(recipe: .stub0)
}
