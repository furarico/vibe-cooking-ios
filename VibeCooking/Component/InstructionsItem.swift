//
//  InstructionsItem.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct InstructionsItem: View {
    let instruction: Instruction

    var body: some View {
        HStack(alignment: .top) {
            StepBadge(step: instruction.step)

            VStack(alignment: .leading, spacing: 8) {
                Text(instruction.title)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)

                Text(instruction.description)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    InstructionsItem(instruction: .stub0)
        .padding()
}
