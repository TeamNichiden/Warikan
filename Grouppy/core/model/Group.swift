import Foundation

struct Group: Identifiable, Codable, Equatable {
  let id: String
  var name: String
  var description: String
  var ownerId: String
  var memberIds: [String]
  var eventIds: [String]
  var createdAt: Date
  var updatedAt: Date

  // アプリ内キャッシュ
  var members: [User]? = nil
  var events: [Event]? = nil
}
