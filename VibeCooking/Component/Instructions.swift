//
//  VibeCooking
//
//

import SwiftUI

struct InstructionsItemData {
    let step: Int
    let title: String?
    let description: String
}

struct Instructions: View {
    let steps: [InstructionsItemData]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("手順")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 16) {
                ForEach(steps.indices, id: \.self) { index in
                    InstructionsItem(
                        step: steps[index].step,
                        title: steps[index].title,
                        description: steps[index].description
                    )
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions(steps: [
            InstructionsItemData(
                step: 1,
                title: "野菜を切る",
                description: "玉ねぎを薄切りに、人参を細切りにします。"
            ),
            InstructionsItemData(
                step: 2,
                title: nil,
                description: "フライパンに油を熱し、野菜を炒めます。"
            ),
            InstructionsItemData(
                step: 3,
                title: "調味料を加える",
                description: "塩、胡椒、醤油を加えて味を調えます。"
            )
        ])
        .padding()
    }
}
