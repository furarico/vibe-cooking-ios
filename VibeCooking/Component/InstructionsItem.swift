//
//  InstructionsItem.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct InstructionsItem: View {
    private let instruction: Components.Schemas.Instruction

    init(instruction: Components.Schemas.Instruction) {
        self.instruction = instruction
    }

    var body: some View {
        if !instruction.title.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    StepBadge(step: instruction.step)

                    Text(instruction.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)

                    Spacer()
                }

                HStack {
                    Spacer()
                        .frame(width: 40)

                    Text(instruction.description)
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
            }
        } else {
            HStack(alignment: .top, spacing: 8) {
                StepBadge(step: instruction.step)

                Text(instruction.description)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
        }
    }
}

#Preview {
    InstructionsItem(instruction: Components.Schemas.Instruction.stub0)
}
