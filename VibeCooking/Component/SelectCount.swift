//
//  VibeCooking
//
//

import SwiftUI

struct SelectCount: View {
    let count: Int
    
    var body: some View {
        if count > 0 {
            Text("\(count)")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Color(red: 0.28, green: 0.31, blue: 0.36))
                .clipShape(Circle())
        }
    }
}

struct SelectCount_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            SelectCount(count: 0)
            SelectCount(count: 1)
            SelectCount(count: 5)
            SelectCount(count: 99)
        }
        .padding()
    }
}
