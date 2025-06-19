//
//  VibeCooking
//
//

import SwiftUI

struct RecipeDetailHeader: View {
    let title: String?
    let description: String?
    let tags: [String]?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                if let title = title, !title.isEmpty {
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                if let description = description, !description.isEmpty {
                    Text(description)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                }
            }
            
            if let tags = tags, !tags.isEmpty {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                        }) {
                            Text("#\(tag)")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RecipeDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            RecipeDetailHeader(
                title: "チキンカレー",
                description: "スパイシーで美味しいチキンカレーです。家族みんなで楽しめる本格的な味わいです。",
                tags: ["カレー", "チキン", "スパイス", "メイン"]
            )
            
            RecipeDetailHeader(
                title: "シンプルサラダ",
                description: nil,
                tags: ["サラダ", "ヘルシー"]
            )
            
            RecipeDetailHeader(
                title: "パスタボロネーゼ",
                description: "本格的なボロネーゼソースのパスタです。",
                tags: nil
            )
        }
        .padding()
    }
}
