//
//  AudioPlayerHelper.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/26.
//

import AVFoundation

final actor AudioPlayer: NSObject {
    static let shared = AudioPlayer()

    private var player: AVAudioPlayer?

    private var onPlayingAudioFinished: (@Sendable () -> Void)?

    private override init() {
        super.init()

        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker, .duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            Logger.error("Failed to set audio session category: \(error)")
        }
    }

    func playAudio(from url: URL, onFinished: @escaping @Sendable () -> Void) async throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .duckOthers])
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        onPlayingAudioFinished = onFinished
        let data = try await URLSession.shared.data(from: url).0
        player = try AVAudioPlayer(data: data)
        player?.prepareToPlay()
        player?.delegate = self
        player?.play()
    }

    func stopAudio() {
        player?.stop()
        player = nil
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Logger.debug("Audio finished playing: \(flag)")
        Task { [weak self] in
            if let onPlayingAudioFinished = await self?.onPlayingAudioFinished {
                onPlayingAudioFinished()
            }
        }
    }
}
