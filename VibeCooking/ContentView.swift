//
//  ContentView.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct ContentView<Environment: EnvironmentProtocol>: View {
    @State private var isVibeCookingListPresented: Bool = false

    var body: some View {
        NavigationStack {
            RecipeListScreen<Environment>()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isVibeCookingListPresented = true
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
                .sheet(isPresented: $isVibeCookingListPresented) {
                    VibeCookingListScreen<Environment>()
                }
        }
    }
}

#Preview {
    ContentView<MockEnvironment>()
}
