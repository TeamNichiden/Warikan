import Foundation

protocol UserRepository {
  func fetchUser(id: String) async throws -> AppUser?
  func fetchUsers(ids: [String]) async throws -> [AppUser]
}

class MockUserRepositoryImpl: UserRepository {
  func fetchUser(id: String) async throws -> AppUser? {
    guard let uuid = UUID(uuidString: id) else { return nil }
    return MockData.users.first(where: { $0.id == uuid })
  }

  func fetchUsers(ids: [String]) async throws -> [AppUser] {
    let uuids = ids.compactMap { UUID(uuidString: $0) }
    return MockData.users.filter { uuids.contains($0.id) }
  }
}
