//
//  CookingService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

final actor CookingService<Environment: EnvironmentProtocol> {
    func startListening() async -> AsyncStream<VoiceCommand> {
        await Environment.shared.audioRepository.stopAudio()
        return AsyncStream { continuation in
            Task {
                for await result in await Environment.shared.speechRecognitionRepository.startTranscribing() {
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

    func playAudio(url: URL, onFinished: @escaping () -> Void) async throws {
        await Environment.shared.speechRecognitionRepository.stopTranscribing()
        Logger.debug("Playing audio from \(url)")
        await Environment.shared.audioRepository.stopAudio()
        try await Environment.shared.audioRepository.playAudio(from: url, onFinished: onFinished)
    }

    func stopAll() async {
        await Environment.shared.speechRecognitionRepository.stopTranscribing()
        await Environment.shared.audioRepository.stopAudio()
    }
}
