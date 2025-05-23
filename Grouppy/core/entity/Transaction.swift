import Foundation

struct Transaction: Identifiable, Codable, Equatable {
  let id: String  // 取引のUUID（主キー）
  var eventId: String  // 関連イベントのUUID
  var payerId: String  // 支払者のユーザーID
  var payeeIds: [String]  // 割り勘対象者のユーザーID配列
  var amount: Int  // 割り勘対象金額
  var totalAmount: Int  // 合計金額
  var memo: String
  var createdAt: Date
  var updatedAt: Date

  // アプリ内で使う場合のキャッシュ（API通信時は使わない）
  var payer: User? = nil
  var payees: [User]? = nil
}
