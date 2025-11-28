//
//  CookingInstructionCard.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct CookingInstructionCard: View {
    let instruction: Instruction

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                StepBadge(step: instruction.step)

                Text(instruction.title)
                    .font(.title2)
                    .bold()
                    .lineLimit(1)

                Spacer()
            }

            Text(instruction.description)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    CookingInstructionCard(instruction: .stub0)
        .padding()
}

#Preview {
    CookingInstructionCard(instruction: .stub1)
        .padding()
}

#Preview {
    CookingInstructionCard(instruction: .stub2)
        .padding()
}
