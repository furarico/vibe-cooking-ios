//
//  VoiceCommand.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/20.
//

import Foundation

enum VoiceCommand: String, Codable, CaseIterable {
    case goBack
    case goForward
    case again
    case startTimer
    case none

    var triggerPhrase: [String] {
        switch self {
        case .goBack:
            return [
                "前",
                "まえ",
                "マエ",
                "前の",
                "まえの",
                "バック",
                "back",
                "戻る",
                "もどる",
                "もどって",
                "戻って",
            ]

        case .goForward:
            return [
                "次",
                "つぎ",
                "ツギ",
                "次の",
                "つぎの",
                "ネクスト",
                "next",
                "進んで",
                "うぃシェフ",
                "ウィシェフ",
            ]

        case .again:
            return [
                "もう一度",
                "もういちど",
                "モウイチド",
                "もう1度",
                "もう１度",
                "again",
                "アゲイン",
                "repeat",
                "リピート",
                "繰り返し",
                "くりかえし",
                "もっかい",
                "もういっかい",
                "もういっちょう",
                "もう一回",
            ]

        case .startTimer:
            return [
                "タイマー",
                "スタート",
                "タイマースタート",
                "タイマー開始",
            ]

        case .none:
            return []
        }
    }

    init(transcript: String) {
        for command in VoiceCommand.allCases {
            if command.triggerPhrase.contains(where: { transcript.localizedCaseInsensitiveContains($0) }) {
                self = command
                return
            }
        }
        self = .none
    }
}
