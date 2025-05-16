import SwiftUI

struct GroupCard: View {
  let action: () -> Void
  let btnImg: String
  let title: String
  let message: String

  var body: some View {
    HStack {
      Button(action: action) {
        Image(systemName: btnImg)
          .font(.system(size: 40))
      }
      Spacer()
      HStack {
        VStack(alignment: .leading) {
          Text(title)
            .fontWeight(.bold)
            .padding(.bottom, 8)
          Text(message)
            .font(.caption)
            .foregroundColor(Color.gray)
        }
      }
      .frame(width: 200)
    }
    .padding()
    .frame(maxWidth: .infinity)
    .overlay(
      RoundedRectangle(cornerRadius: 15)
        .stroke(Color(.systemGray4), lineWidth: 1)
    )
  }
}

#Preview {
  GroupCard(action: {}, btnImg: "plus.circle.fill", title: "グループ作成", message: "新しいグループを作成する")
}
