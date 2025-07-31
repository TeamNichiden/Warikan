import Foundation

protocol UserUseCase {
  func fetchUser(id: String) async throws -> AppUser?
  func fetchUsers(ids: [String]) async throws -> [AppUser]
}

class UserUseCaseImpl: UserUseCase {
  private let repository: UserRepository

  init(repository: UserRepository = MockUserRepositoryImpl()) {
    self.repository = repository
  }

  func fetchUser(id: String) async throws -> AppUser? {
    try await repository.fetchUser(id: id)
  }

  func fetchUsers(ids: [String]) async throws -> [AppUser] {
    try await repository.fetchUsers(ids: ids)
  }
}
