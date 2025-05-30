import Foundation

struct Transaction: Identifiable, Codable, Equatable {
  let id: String  // 取引UUID
  var eventId: String  // 関連イベントUUID
  var payerId: String  // 支払者UUID
  var payeeIds: [String]  // 割り勘対象者UUID配列
  var amount: Int
  var totalAmount: Int
  var memo: String
  var createdAt: Date
  var updatedAt: Date

  // アプリ内で使う場合のキャッシュ（API通信時は使わない）
    var payer: AppUser? = nil
    var payees: [AppUser]? = nil
}
