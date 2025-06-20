//
//  VibeCooking
//
//

import SwiftUI

struct StepBadge: View {
    private let step: Int

    init(step: Int) {
        self.step = step
    }

    var body: some View {
        Text(step.description)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 32, height: 32)
            .background(Color.secondary)
            .clipShape(Circle())
    }
}

#Preview {
    StepBadge(step: 1)
    StepBadge(step: 5)
    StepBadge(step: 10)
}
