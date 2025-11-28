//
//  SpeechRecognitionRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Dependencies
import DependenciesMacros
import Speech

enum TranscriptionResult {
    case success(String)
    case failure(Error)
}

@DependencyClient
struct SpeechRecognitionRepository {
    var startTranscribing: @Sendable () async throws -> AsyncStream<TranscriptionResult>
    var stopTranscribing: @Sendable () async -> Void
    var clearTranscriptions: @Sendable () async throws -> Void
}

extension SpeechRecognitionRepository: DependencyKey {
    static let liveValue: SpeechRecognitionRepository = {
        let helper = SpeechRecognitionHelper()
        return SpeechRecognitionRepository(
            startTranscribing: {
                try await helper.startTranscribing()
            },
            stopTranscribing: {
                await helper.stopTranscribing()
            },
            clearTranscriptions: {
                try await helper.clearTranscriptions()
            }
        )
    }()
}

extension DependencyValues {
    var speechRecognitionRepository: SpeechRecognitionRepository {
        get { self[SpeechRecognitionRepository.self] }
        set { self[SpeechRecognitionRepository.self] = newValue }
    }
}
