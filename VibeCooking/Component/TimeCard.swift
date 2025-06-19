//
//  VibeCooking
//
//

import SwiftUI

enum TimeCardVariant {
    case prep
    case cook
    case servings
    
    var title: String {
        switch self {
        case .prep: return "準備時間"
        case .cook: return "調理時間"
        case .servings: return "分量"
        }
    }
    
    var icon: String {
        switch self {
        case .prep, .cook: return "clock"
        case .servings: return "person.2"
        }
    }
    
    var unit: String {
        switch self {
        case .prep, .cook: return "分"
        case .servings: return "人前"
        }
    }
}

struct TimeCard: View {
    let variant: TimeCardVariant
    let number: Int
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: variant.icon)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                Text(variant.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Text("\(number) \(variant.unit)")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct TimeCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 16) {
            TimeCard(variant: .prep, number: 15)
            TimeCard(variant: .cook, number: 30)
            TimeCard(variant: .servings, number: 4)
        }
        .padding()
    }
}
