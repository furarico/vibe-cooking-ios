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
            RecipeListScreen<EnvironmentImpl>()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
                .sheet(isPresented: .constant(false)) {
                }
        }
    }
}

#Preview {
    ContentView()
}
