//
//  Instructions.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
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
        }
    }
}

#Preview {
    Instructions(instructions: Components.Schemas.Instruction.stubs0)
}
