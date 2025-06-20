//
//  AudioRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Foundation
import AVFoundation

protocol AudioRepositoryProtocol {
    func playAudio(from url: URL, onFinished: @escaping () -> Void) async throws
    func stopAudio() async
}

final actor AudioRepositoryImpl: NSObject, AudioRepositoryProtocol {
    private var player: AVAudioPlayer?

    private var onPlayingAudioFinished: (() -> Void)?

    override init() {
        super.init()

        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker, .duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            Logger.error("Failed to set audio session category: \(error)")
        }
    }

    func playAudio(from url: URL, onFinished: @escaping () -> Void) async throws {
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

extension AudioRepositoryImpl: AVAudioPlayerDelegate {
    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Logger.debug("Audio finished playing: \(flag)")
        Task { [weak self] in
            if let onPlayingAudioFinished = await self?.onPlayingAudioFinished {
                onPlayingAudioFinished()
            }
        }
    }
}
