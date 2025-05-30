import Foundation

struct AppUser: Identifiable, Codable, Equatable {
  let id: UUID  // ユーザーUUID
  var name: String
  var email: String
  var userId: String
  var iconUrl: URL?
  // 必要に応じて追加フィールド
}
