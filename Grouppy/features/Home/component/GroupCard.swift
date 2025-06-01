import SwiftUI

struct GroupCard: View {
  let action: () -> Void
  let title: String
  let textColor: Color
  let backgroundColor: Color

  var body: some View {
      Button(action: action) {
          Text(title)
              .foregroundColor(textColor)
              .fontWeight(.bold)
              .padding(18)
              .frame(maxWidth: .infinity, minHeight: 50)
              .background(backgroundColor)
              .cornerRadius(12)
      }
  }
}

#Preview {
    GroupCard(
        action: {},
        title: "イベント作成",
        textColor: .white,
        backgroundColor: .blue
    )
}
