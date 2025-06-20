//
//  VibeCooking
//
//

import SwiftUI

struct CookingInstructionCard: View {
    private let instruction: Components.Schemas.Instruction

    init(instruction: Components.Schemas.Instruction) {
        self.instruction = instruction
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                StepBadge(step: instruction.step)
                
                Text(instruction.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            VStack(alignment: .center, spacing: 16) {
                Text(instruction.description)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let imageUrl = instruction.imageUrl, !imageUrl.isEmpty {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 2)
                    )
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    CookingInstructionCard(
        instruction: Components.Schemas.Instruction.stub0
    )
}

#Preview {
    CookingInstructionCard(
        instruction: Components.Schemas.Instruction.stub1
    )
}

#Preview {
    CookingInstructionCard(
        instruction: Components.Schemas.Instruction.stub2
    )
}
