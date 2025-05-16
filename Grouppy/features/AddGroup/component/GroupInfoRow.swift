import SwiftUI

struct GroupInfoRow: View {
  let title: String
  let message: String
  @Binding var inputMessage: String
  var isInputText: Bool = false
  var btnIcon: String? = nil
  var action: (() -> Void)? = nil

  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .fontWeight(.bold)
      HStack {
        TextField(message, text: $inputMessage)
          .disabled(isInputText)
        if let btnIcon, let action {
          Button(action: action) {
            Image(systemName: btnIcon)
          }
        }
      }
      .padding()
      .background(Color(.systemGray6))
      .cornerRadius(8)
    }
  }
}

#Preview {
  GroupInfoRow(title: "グループ名", message: "グループ名を入力", inputMessage: .constant(""))
}
