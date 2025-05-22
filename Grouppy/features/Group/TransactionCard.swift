import SwiftUI

struct Card: Identifiable {
  let id = UUID()
  let payerId: String
  let amount: Int
  let description: String
  let members: [String]  // 全メンバー
  let paidMembers: [String]  // すでに支払った人
}

struct CardStackView: View {
  @Binding var cards: [Card]

    var body: some View {
        ZStack {
            TabView {
                ForEach(cards.reversed()) { card in
                    CardView(
                        card: card
                    )
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 400)

        }
    }

  private func index(of card: Card) -> Int {
    return cards.firstIndex(where: { $0.id == card.id }) ?? 0
  }
}

struct CardView: View {
  let card: Card

  @State private var offset = CGSize.zero

  var body: some View {
        VStack(alignment: .leading, spacing: 10) {
          // 上部：建て替えた人・内容
          Text(card.payerId)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.top, 12)
          Text(card.description)
            .font(.body)
            .foregroundColor(.black.opacity(0.9))
          Spacer()
          // 建て替え金額
          Text("建て替え金額")
            .font(.caption)
            .foregroundColor(.black.opacity(0.8))
          HStack {
            Spacer()
            Text("¥\(card.amount)")
              .font(.title)
              .fontWeight(.bold)
              .foregroundColor(.black)
          }
          Divider().background(Color.black.opacity(0.3))
          // すでに支払った人リスト
          Text("すでに支払った人")
            .font(.caption)
            .foregroundColor(.black.opacity(0.8))
          VStack(spacing: 8) {
            ForEach(card.paidMembers, id: \.self) { member in
              HStack(spacing: 12) {
                Circle()
                  .fill(Color.green.opacity(0.15))
                  .frame(width: 32, height: 32)
                  .overlay(
                    Text(String(member.prefix(1)))
                      .font(.headline)
                      .foregroundColor(.green)
                  )
                Text("\(member)さんが支払いました")
                  .font(.body)
                  .foregroundColor(.black)
                Spacer()
                Text("¥\(card.amount)")
                  .fontWeight(.medium)
                  .foregroundColor(.black)
              }
              .padding(.vertical, 6)
              .padding(.horizontal, 10)
              .background(Color.gray.opacity(0.15))
              .cornerRadius(14)
            }
          }
          .padding(.bottom, 8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
  }
}

struct DemoView: View {
  var body: some View {
      CardStackView(cards: . constant([
        Card(payerId: "Alice", amount: 1000, description: "Dinner", members: ["Alice", "Bob"], paidMembers: ["Alice"]),
        Card(payerId: "Bob", amount: 2000, description: "Lunch", members: ["Alice", "Bob"], paidMembers: ["Bob"]),
        Card(payerId: "Charlie", amount: 3000, description: "Snacks", members: ["Alice", "Bob"], paidMembers: ["Charlie"])
        ]))
  }
}

#Preview {
  DemoView()
}
