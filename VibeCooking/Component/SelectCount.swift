//
//  SelectCount.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct SelectCount: View {
    let count: Int

    var body: some View {
        if count > 0 {
            Text(count.description)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Color.secondary)
                .clipShape(Circle())
        }
    }
}

#Preview {
    SelectCount(count: 0)
    SelectCount(count: 1)
    SelectCount(count: 5)
    SelectCount(count: 99)
}
