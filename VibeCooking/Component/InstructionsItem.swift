//
//  VibeCooking
//
//

import SwiftUI

struct InstructionsItem: View {
    let step: Int
    let title: String?
    let description: String
    
    var body: some View {
        if let title = title, !title.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    StepBadge(step: step)
                    
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                        .frame(width: 40)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            }
        } else {
            HStack(alignment: .top, spacing: 8) {
                StepBadge(step: step)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
    }
}

struct InstructionsItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            InstructionsItem(
                step: 1,
                title: "野菜を切る",
                description: "玉ねぎを薄切りに、人参を細切りにします。"
            )
            
            InstructionsItem(
                step: 2,
                title: nil,
                description: "フライパンに油を熱し、野菜を炒めます。"
            )
            
            InstructionsItem(
                step: 3,
                title: "調味料を加える",
                description: "塩、胡椒、醤油を加えて味を調えます。全体に味が馴染むまでよく混ぜ合わせてください。"
            )
        }
        .padding()
    }
}
