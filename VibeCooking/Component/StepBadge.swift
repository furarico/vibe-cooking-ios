//
//  VibeCooking
//
//

import SwiftUI

struct StepBadge: View {
    let step: Int
    
    var body: some View {
        Text("\(step)")
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 32, height: 32)
            .background(Color(red: 0.28, green: 0.31, blue: 0.36))
            .clipShape(Circle())
    }
}

struct StepBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            StepBadge(step: 1)
            StepBadge(step: 5)
            StepBadge(step: 10)
        }
        .padding()
    }
}
