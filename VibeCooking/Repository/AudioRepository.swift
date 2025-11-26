//
//  AudioRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
struct AudioRepository {
    var playAudio: @Sendable (_ url: URL, _ onFinished: @escaping @Sendable () -> Void) async throws -> Void
    var stopAudio: @Sendable () async -> Void
}

extension AudioRepository: DependencyKey {
    static let liveValue: AudioRepository = AudioRepository(
        playAudio: { url, onFinished in
            try await AudioPlayer.shared.playAudio(from: url, onFinished: onFinished)
        },
        stopAudio: {
            await AudioPlayer.shared.stopAudio()
        }
    )
}

extension DependencyValues {
    var audioRepository: AudioRepository {
        get { self[AudioRepository.self] }
        set { self[AudioRepository.self] = newValue }
    }
}
