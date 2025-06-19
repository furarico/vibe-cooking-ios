//
//  VibeCooking
//
//

import SwiftUI

struct IngredientsItem: View {
    let name: String
    let amount: String
    let unit: String
    let note: String?
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                if let note = note, !note.isEmpty {
                    Text(note)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            Text("\(amount) \(unit)")
                .font(.system(size: 16))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8)),
            alignment: .bottom
        )
    }
}

struct IngredientsItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            IngredientsItem(name: "トマト", amount: "2", unit: "個", note: nil)
            IngredientsItem(name: "砂糖", amount: "100", unit: "g", note: "上白糖がおすすめ")
            IngredientsItem(name: "卵", amount: "2", unit: "個", note: nil)
            IngredientsItem(name: "牛乳", amount: "150", unit: "ml", note: nil)
        }
        .padding()
    }
}
