//
//  Instruction.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

struct Instruction: Equatable, Identifiable {
    let id: String
    let recipeId: String
    let step: Int
    let title: String
    let description: String
    let audioURL: URL?
    let timerDuration: TimeInterval
}
