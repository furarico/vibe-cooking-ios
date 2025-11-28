//
//  VibeChefAnimation.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import SwiftUI


struct VibeChefAnimation: View {
    let isListening: Bool

    var body: some View {
        if isListening {
            LottieView(name: "listening")
        } else {
            LottieView(name: "speaking")
        }
    }
}

#Preview {
    VibeChefAnimation(isListening: true)
    VibeChefAnimation(isListening: false)
}
