//
//  VibeCooking
//
//

import SwiftUI

struct InstructionsItem: View {
    enum Variant {
        case normal
        case card
    }

    private let variant: Variant
    private let instruction: Components.Schemas.Instruction

    init(variant: Variant = .normal, instruction: Components.Schemas.Instruction) {
        self.variant = variant
        self.instruction = instruction
    }

    var body: some View {
        switch variant {
        case .normal:
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

        case .card:
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

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(16)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    InstructionsItem(instruction: Components.Schemas.Instruction.stub0)
}

#Preview {
    InstructionsItem(variant: .normal, instruction: Components.Schemas.Instruction.stub0)
}

#Preview {
    InstructionsItem(variant: .card, instruction: Components.Schemas.Instruction.stub0)
        .padding()
}
