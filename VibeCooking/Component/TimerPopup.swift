//
//  TimerPopup.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import SwiftUI

struct TimerPopup: View {
    let interval: TimeInterval
    let onStartButtonTapped: () -> Void

    private var duration: Range<Date> {
        let now = Date()
        return now..<now.addingTimeInterval(interval)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("タイマーをセットしますか？")
            HStack {
                Text(duration, format: .timeDuration)
                    .font(.title)
                    .monospacedDigit()
                    .bold()
                    .lineLimit(1)
                Spacer()
                Button(action: onStartButtonTapped) {
                    Image(systemName: "play.fill")
                        .font(.title3)
                        .padding(4)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.glassProminent)
                .tint(.black)
            }
        }
    }
}

#Preview {
    TimerPopup(interval: 120) {
    }
    .padding()
}
