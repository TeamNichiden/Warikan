import Foundation

struct Event: Identifiable, Codable, Equatable {
  let id: String  // イベントのUUID（主キー）
  var title: String
  var description: String
  var date: Date
  var place: String
  var ownerId: String  // イベント作成者のユーザーID
  var participantIds: [String]  // 参加者のユーザーID配列
  var transactions: [Transaction]  // 関連取引の詳細情報配列
  var createdAt: Date
  var updatedAt: Date

  // アプリ内で使う場合のキャッシュ（API通信時は使わない）
    var participants: [AppUser]? = nil
}
