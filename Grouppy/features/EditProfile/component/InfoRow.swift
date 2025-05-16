import SwiftUI

struct InfoRow: View {
  let title: String
  @Binding var inputText: String
  var isEditable: Bool = true
  var submitLabel: String? = nil
  var submitAction: (() -> Void)? = nil

  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .fontWeight(.bold)
      HStack {
        TextField("", text: $inputText)
          .foregroundColor(isEditable ? .black : .gray)
          .disabled(!isEditable)
        if !isEditable, let submitLabel = submitLabel, let submitAction = submitAction {
          Button(action: submitAction) {
            Text(submitLabel)
          }
        }
      }
      .padding()
      .background(Color(.systemGray6))
      .cornerRadius(10)
    }
  }
}

#Preview {
  InfoRow(title: "ニックネーム", inputText: .constant("テスト"))
}
