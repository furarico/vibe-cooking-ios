//
//  ContentView.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            RecipeListView<EnvironmentImpl>()
        }
    }
}

#Preview {
    ContentView()
}
