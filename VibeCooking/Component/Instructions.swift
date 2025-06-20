//
//  VibeCooking
//
//

import SwiftUI

struct Instructions: View {
    private let instructions: [Components.Schemas.Instruction]

    init(instructions: [Components.Schemas.Instruction]) {
        self.instructions = instructions.sorted { $0.step < $1.step }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("手順")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 16) {
                ForEach(instructions) { instruction in
                    InstructionsItem(instruction: instruction)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    Instructions(instructions: Components.Schemas.Instruction.stubs0)
}
