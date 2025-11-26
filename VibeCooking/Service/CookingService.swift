//
//  CookingService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Dependencies
import Foundation

final actor CookingService {
    @Dependency(\.audioRepository) private var audioRepository
    @Dependency(\.speechRecognitionRepository) private var speechRecognitionRepository

    func startListening() async -> AsyncStream<VoiceCommand> {
        await audioRepository.stopAudio()
        return AsyncStream { continuation in
            Task {
                for await result in try await speechRecognitionRepository.startTranscribing() {
                    switch result {
                    case .success(let transcript):
                        Logger.debug(transcript)
                        continuation.yield(VoiceCommand(transcript: transcript))

                    case .failure(let error):
                        continuation.yield(VoiceCommand.none)
                        Logger.error(error)
                    }
                }
            }
        }
    }

    func playAudio(url: URL, onFinished: @escaping @Sendable () -> Void) async throws {
        await speechRecognitionRepository.stopTranscribing()
        Logger.debug("Playing audio from \(url)")
        await audioRepository.stopAudio()
        try await audioRepository.playAudio(url: url, onFinished: onFinished)
    }

    func stopAll() async {
        await speechRecognitionRepository.stopTranscribing()
        await audioRepository.stopAudio()
    }
}
