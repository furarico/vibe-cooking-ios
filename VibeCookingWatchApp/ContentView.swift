//
//  ContentView.swift
//  VibeCookingWatchApp
//
//  Created by Kanta Oikawa on 2025/10/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "frying.pan")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Detecting...")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
