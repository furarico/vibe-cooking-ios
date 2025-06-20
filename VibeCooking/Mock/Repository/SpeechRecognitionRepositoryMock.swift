//
//  SpeechRecognitionRepositoryMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Foundation

final actor SpeechRecognitionRepositoryMock: SpeechRecognitionRepositoryProtocol {
    func startTranscribing() -> AsyncStream<TranscriptionResult> {
        AsyncStream { _ in
        }
    }
    
    func stopTranscribing() {
    }
}
