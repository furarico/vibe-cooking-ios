//
//  VibeCooking
//
//

import SwiftUI

struct IngredientsItemData {
    let name: String
    let amount: String
    let unit: String
    let note: String?
}

struct Ingredients: View {
    let ingredients: [IngredientsItemData]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("材料")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 0) {
                ForEach(ingredients.indices, id: \.self) { index in
                    IngredientsItem(
                        name: ingredients[index].name,
                        amount: ingredients[index].amount,
                        unit: ingredients[index].unit,
                        note: ingredients[index].note
                    )
                }
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 16)
        }
    }
}

struct Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        Ingredients(ingredients: [
            IngredientsItemData(name: "小麦粉", amount: "200", unit: "g", note: nil),
            IngredientsItemData(name: "砂糖", amount: "100", unit: "g", note: "上白糖がおすすめ"),
            IngredientsItemData(name: "卵", amount: "2", unit: "個", note: nil),
            IngredientsItemData(name: "牛乳", amount: "150", unit: "ml", note: nil)
        ])
        .padding()
    }
}
