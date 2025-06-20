//
//  CookingService.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

final actor CookingService<Environment: EnvironmentProtocol> {
    func startListening() -> AsyncStream<VoiceCommand> {
        AsyncStream { continuation in
            Task {
                for await result in await Environment.shared.speechRecognitionRepository.startTranscribing() {
                    switch result {
                    case .success(let transcript):
                        continuation.yield(VoiceCommand(transcript: transcript))

                    case .failure(let error):
                        continuation.yield(VoiceCommand.none)
                        Logger.error(error)
                    }
                }
            }
        }
    }

    func stopListening() async {
        await Environment.shared.speechRecognitionRepository.stopTranscribing()
    }
}
