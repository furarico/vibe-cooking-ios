//
//  SpeechView.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct SpeechView: View {
    @State private var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false

    var body: some View {
        VStack {
            Text(speechRecognizer.transcript)

            if isRecording {
                Text("Recording...")
            } else {
                Text("Tap to start recording")
            }
        }
        .onTapGesture {
            if isRecording {
                speechRecognizer.stopTranscribing()
                isRecording = false
            } else {
                speechRecognizer.startTranscribing()
                isRecording = true
            }
        }
        .onAppear {
            speechRecognizer.resetTranscript()
            speechRecognizer.startTranscribing()
            isRecording = true
        }
        .onDisappear {
            speechRecognizer.stopTranscribing()
            isRecording = false
        }
    }
}

#Preview {
    SpeechView()
}
