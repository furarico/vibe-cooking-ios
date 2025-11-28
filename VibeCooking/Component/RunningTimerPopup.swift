//
//  RunningTimerPopup.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import SwiftUI

struct RunningTimerPopup: View {
    let timer: CookingTimer
    let onStopButtonTapped: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("タイマー 残り")
            HStack {
                Text(timer.duration.upperBound, style: .timer)
                    .font(.title)
                    .monospacedDigit()
                    .bold()
                    .lineLimit(1)
                Spacer()
                Button(action: onStopButtonTapped) {
                    Image(systemName: "stop.fill")
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
    RunningTimerPopup(
        timer: CookingTimer(
            alarmID: UUID(),
            instructionID: UUID().uuidString,
            duration: Date()..<Date().addingTimeInterval(10)
        )
    ) {
    }
    .padding()
}
