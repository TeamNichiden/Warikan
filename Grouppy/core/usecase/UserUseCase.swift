import Foundation

protocol UserUseCase {
  func fetchUser(id: String) async throws -> User?
  func fetchUsers(ids: [String]) async throws -> [User]
}

class UserUseCaseImpl: UserUseCase {
  private let repository: UserRepository

  init(repository: UserRepository = MockUserRepositoryImpl()) {
    self.repository = repository
  }

  func fetchUser(id: String) async throws -> User? {
    try await repository.fetchUser(id: id)
  }

  func fetchUsers(ids: [String]) async throws -> [User] {
    try await repository.fetchUsers(ids: ids)
  }
}
