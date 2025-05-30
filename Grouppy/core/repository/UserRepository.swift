import Foundation

protocol UserRepository {
  func fetchUser(id: String) async throws -> User?
  func fetchUsers(ids: [String]) async throws -> [User]
}

class MockUserRepositoryImpl: UserRepository {
  func fetchUser(id: String) async throws -> User? {
    MockData.users.first(where: { $0.id == id })
  }

  func fetchUsers(ids: [String]) async throws -> [User] {
    MockData.users.filter { ids.contains($0.id) }
  }
}
