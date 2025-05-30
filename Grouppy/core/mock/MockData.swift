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
  ]

  static var events: [Event] = [
    Event(
      id: "event-001",
      groupId: "group-001",
      title: "4月の歓迎会",
      description: "新入社員の歓迎会です",
      date: Date(timeIntervalSince1970: 1_713_522_000),
      place: "渋谷 居酒屋",
      ownerId: "user-001",
      participantIds: ["user-001", "user-002", "user-003"],
      transactionIds: ["txn-001", "txn-002"],
      createdAt: Date(timeIntervalSince1970: 1_713_518_400),
      updatedAt: Date(timeIntervalSince1970: 1_713_536_400),
      participants: users,
      transactions: transactions
    )
  ]

  static var groups: [Group] = [
    Group(
      id: "group-001",
      name: "飲み会グループ",
      description: "4月の飲み会グループ",
      ownerId: "user-001",
      memberIds: ["user-001", "user-002", "user-003"],
      eventIds: ["event-001"],
      createdAt: Date(timeIntervalSince1970: 1_713_510_000),
      updatedAt: Date(timeIntervalSince1970: 1_713_536_400),
      members: users,
      events: events
    )
  ]
}
