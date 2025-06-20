//
//  VibeCooking
//
//

import SwiftUI

struct SelectCount: View {
    private let count: Int

    init(count: Int) {
        self.count = count
    }

    var body: some View {
        if count > 0 {
            Text(count.description)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Color.secondary)
                .clipShape(Circle())
        }
    }
}

#Preview {
    SelectCount(count: 0)
    SelectCount(count: 1)
    SelectCount(count: 5)
    SelectCount(count: 99)
}
