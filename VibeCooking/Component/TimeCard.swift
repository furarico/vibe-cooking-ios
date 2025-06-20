//
//  VibeCooking
//
//

import SwiftUI

struct TimeCard: View {
    enum Variant {
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

    private let variant: Variant
    private let number: Int

    init(variant: Variant, number: Int) {
        self.variant = variant
        self.number = number
    }

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
                .stroke(Color.secondary, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    HStack {
        TimeCard(variant: .prep, number: 15)
        TimeCard(variant: .cook, number: 30)
        TimeCard(variant: .servings, number: 4)
    }
}
