import Foundation

struct User: Identifiable, Codable, Equatable {
  let id: String  // ユーザーUUID
  var name: String
  var email: String
  var userId: String?
  var iconUrl: URL?
  // 必要に応じて追加フィールド
}
