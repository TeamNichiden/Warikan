import Foundation

struct MockData {
    static let users: [AppUser] = [
        AppUser(
      id: UUID(), name: "山田 太郎", email: "taro@example.com", userId: "taro",
      iconUrl: URL(string: "https://example.com/icon1.png")),
        AppUser(
      id: UUID(), name: "佐藤 花子", email: "hanako@example.com", userId: "hanako",
      iconUrl: URL(string: "https://example.com/icon2.png")),
        AppUser(id: UUID(), name: "鈴木 次郎", email: "jiro@example.com", userId: "jiro", iconUrl: nil),
  ]

    static let authUser: AppUser = users[0]

  static var transactions: [Transaction] = [
    Transaction(
      id: "txn-001",
      eventId: "event-001",
      payerId: "user-001",
      payeeIds: ["user-002", "user-003"],
      amount: 10000,
      totalAmount: 30000,
      memo: "一次会分",
      createdAt: Date(timeIntervalSince1970: 1_713_525_600),
      updatedAt: Date(timeIntervalSince1970: 1_713_525_600),
      payer: users[0],
      payees: [users[1], users[2]]
    ),
    Transaction(
      id: "txn-002",
      eventId: "event-001",
      payerId: "user-002",
      payeeIds: ["user-001", "user-003"],
      amount: 5000,
      totalAmount: 15000,
      memo: "二次会分",
      createdAt: Date(timeIntervalSince1970: 1_713_532_800),
      updatedAt: Date(timeIntervalSince1970: 1_713_532_800),
      payer: users[1],
      payees: [users[0], users[2]]
    ),
    Transaction(
      id: "txn-003",
      eventId: "event-001",
      payerId: "user-003",
      payeeIds: ["user-001", "user-002"],
      amount: 5000,
      totalAmount: 15000,
      memo: "二次会分",
      createdAt: Date(timeIntervalSince1970: 1_713_532_800),
      updatedAt: Date(timeIntervalSince1970: 1_713_532_800),
      payer: users[2],
      payees: [users[0], users[1]]
    )
  ]

  static var events: [Event] = [
    Event(
      id: "event-001",
      title: "夏祭りイベント",
      description: "新年会です。飲み放題プランで予約済み。参加費は一人3000円程度を予定しています。",
      date: Date(timeIntervalSince1970: 1_713_522_000).dateToString(),
      place: "渋谷 居酒屋 鳥貴族",
      ownerId: "user-001",
      participantIds: ["user-001", "user-002", "user-003"],
      transactions: transactions,
      createdAt: Date(timeIntervalSince1970: 1_713_518_400),
      updatedAt: Date(timeIntervalSince1970: 1_713_536_400),
      participants: users
    ),
    Event(
      id: "event-002",
      title: "週末ハイキング",
      description: "新年会です。飲み放題プランで予約済み。参加費は一人3000円程度を予定しています。",
      date: Date(timeIntervalSince1970: 1_713_522_000).dateToString(),
      place: "渋谷 居酒屋 鳥貴族",
      ownerId: "user-002",
      participantIds: ["user-001", "user-002", "user-003"],
      transactions: transactions,
      createdAt: Date(timeIntervalSince1970: 1_713_518_400),
      updatedAt: Date(timeIntervalSince1970: 1_713_536_400),
      participants: users
    ),
    Event(
      id: "event-003",
      title: "テクノロジーカンファレンス",
      description: "新年会です。飲み放題プランで予約済み。参加費は一人3000円程度を予定しています。",
      date: Date(timeIntervalSince1970: 1_713_522_000).dateToString(),
      place: "渋谷 居酒屋 鳥貴族",
      ownerId: "user-003",
      participantIds: ["user-001", "user-002", "user-003"],
      transactions: transactions,
      createdAt: Date(timeIntervalSince1970: 1_713_518_400),
      updatedAt: Date(timeIntervalSince1970: 1_713_536_400),
      participants: users
    )
  ]
}
