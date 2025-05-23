import SwiftUI

struct MiniHistoryRow: View {
  let message: String
  let price: String
  var body: some View {
    HStack {
      Circle()
        .fill(.green)
      Spacer()
      Text(message)
      Spacer()
      Text(price)
    }
    .fixedSize()
  }
}

#Preview {
  MiniHistoryRow(message: "山田さんが支払いしました", price: "¥1000")
}
