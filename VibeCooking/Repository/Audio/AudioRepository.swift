//
//  AudioRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Foundation
import AVFoundation

protocol AudioRepositoryProtocol {
    func playAudio(from url: URL) async throws
    func stopAudio() async
}

final actor AudioRepositoryImpl: AudioRepositoryProtocol {
    private var audioPlayer: AVAudioPlayer?
    
    func playAudio(from url: URL) async throws {
        let data = try await URLSession.shared.data(from: url).0
        audioPlayer = try AVAudioPlayer(data: data)
        audioPlayer?.play()
    }
    
    func stopAudio() async {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
