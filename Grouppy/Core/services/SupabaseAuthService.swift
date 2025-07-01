import Foundation
import Supabase

protocol SupabaseAuthServiceProtocol {
  func signUp(email: String, password: String) async throws -> AppUser
  func signIn(email: String, password: String) async throws -> AppUser
  func signOut() async throws
  var currentUser: AppUser? { get }
}

final class SupabaseAuthService: SupabaseAuthServiceProtocol {
  private let client: SupabaseClient

  init() {
    self.client = SupabaseClientProvider.shared
  }

  func signUp(email: String, password: String) async throws -> AppUser {
    let session = try await client.auth.signUp(email: email, password: password)
    return AppUser(
      id: UUID(),
      name: "",
      email: session.user.email ?? "",
      userId: "",
      iconUrl: nil
    )
  }

  func signIn(email: String, password: String) async throws -> AppUser {
    let session = try await client.auth.signIn(email: email, password: password)
    return AppUser(
      id: UUID(),
      name: "",
      email: session.user.email ?? "",
      userId: "",
      iconUrl: nil
    )
  }

  func signOut() async throws {
    try await client.auth.signOut()
  }

  var currentUser: AppUser? {
    guard let supabaseUser = client.auth.currentUser else { return nil }
    return AppUser(
      id: UUID(),
      name: "",
      email: supabaseUser.email ?? "",
      userId: "",
      iconUrl: nil
    )
  }

  enum AuthError: Error {
    case noUser
  }
}
