//
//  StepBadge.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct StepBadge: View {
    let step: Int

    var body: some View {
        Text(step.description)
            .font(.footnote)
            .bold()
            .foregroundColor(.white)
            .frame(width: 32, height: 32)
            .background(Color.secondary)
            .clipShape(Circle())
    }
}

#Preview {
    StepBadge(step: 1)
    StepBadge(step: 5)
    StepBadge(step: 10)
}
