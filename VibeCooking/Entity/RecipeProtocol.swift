//
//  RecipeProtocol.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

protocol RecipeProtocol: Hashable, Identifiable {
    var id: String { get }
    var instructions: [Instruction] { get }
}
