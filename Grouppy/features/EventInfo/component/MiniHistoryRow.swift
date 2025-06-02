import SwiftUI

struct MiniHistoryRow: View {
    let message: String
    let price: String
    var body: some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(.systemGray6))
                .cornerRadius(8)
                .shadow(color: .gray, radius: 4, x: 0, y: 4)
            HStack {
                Circle() //ユーザーアイコン
                    .fill(.purple)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 4)
                Text(message)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                Text(price)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            .padding()
        }
        .frame(height: 60) // 固定高度
        .frame(maxWidth: .infinity) // 固定宽度为最大可用宽度
        .padding(.horizontal)
    }
}

#Preview {
    MiniHistoryRow(message: "山田さんが支払いしました", price: "¥1000")
}
