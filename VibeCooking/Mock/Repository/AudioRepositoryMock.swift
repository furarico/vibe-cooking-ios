//
//  AudioRepositoryMock.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Foundation

final actor AudioRepositoryMock: AudioRepositoryProtocol {
    func playAudio(from url: URL, onFinished: @escaping () -> Void) async throws {
    }

    func stopAudio() async {
    }
}
