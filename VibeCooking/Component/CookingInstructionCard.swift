//
//  VibeCooking
//
//

import SwiftUI

struct CookingInstructionCard: View {
    let step: Int?
    let title: String
    let description: String
    let imageUrl: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                if let step = step {
                    StepBadge(step: step)
                }
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            VStack(alignment: .center, spacing: 16) {
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let imageUrl = imageUrl, !imageUrl.isEmpty {
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

struct CookingInstructionCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            CookingInstructionCard(
                step: 1,
                title: "野菜を切る",
                description: "玉ねぎを薄切りに、人参を細切りにします。",
                imageUrl: "https://example.com/vegetables.jpg"
            )
            
            CookingInstructionCard(
                step: nil,
                title: "調味料を加える",
                description: "塩、胡椒、醤油を加えて味を調えます。全体に味が馴染むまでよく混ぜ合わせてください。",
                imageUrl: nil
            )
        }
        .padding()
    }
}
