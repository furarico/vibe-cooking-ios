//
//  Collection+.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
