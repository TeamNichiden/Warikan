import Foundation

struct Event: Identifiable, Codable, Equatable {
  let id: String  // イベントUUID
  var groupId: String  // 所属グループID
  var title: String
  var description: String
  var date: Date
  var place: String
  var ownerId: String  // 作成者ユーザーUUID
  var participantIds: [String]  // 参加者UUID配列
  var transactionIds: [String]  // 関連取引UUID配列
  var createdAt: Date
  var updatedAt: Date

  // アプリ内で使う場合のキャッシュ（API通信時は使わない）
    var participants: [AppUser]? = nil
  var transactions: [Transaction]? = nil
}
