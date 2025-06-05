import SwiftUI

struct EventInfoRow: View {
    let title: String
    let message: String
    @Binding var inputMessage: String
    var isInputText: Bool = false
    var btnIcon: String? = nil
    var showDate: Bool = false
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
                            .font(.title2)
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(showDate ? 90 : 0))
                            .animation(.easeInOut(duration: 0.3), value: showDate)
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
    EventInfoRow(title: "イベント名", message: "イベント名を入力(必須)", inputMessage: .constant(""))
}
