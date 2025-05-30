// Grouppy/core/services/AuthManager.swift
import SwiftUI

private let userDefaultsKey = "currentUser"

class AuthManager: ObservableObject {
  @Published var isLoggedIn: Bool = false
  @Published var user: AppUser? {
    didSet {
      saveUserToUserDefaults()
    }
  }
  @Published var errorMessage: String? = nil
  @Published var isSigningOut: Bool = false
  private let authService: SupabaseAuthServiceProtocol

  init(authService: SupabaseAuthServiceProtocol = SupabaseAuthService()) {
    self.authService = authService

    // UserDefaultsから復元
    if let savedUser = Self.loadUserFromUserDefaults() {
      self.user = savedUser
      self.isLoggedIn = true
    } else if let current = authService.currentUser {
      self.user = current
      self.isLoggedIn = true
    } else {
      self.user = nil
      self.isLoggedIn = false
    }
  }

  @MainActor
  func signUp(email: String, password: String) async -> Bool {
    do {
      let user = try await authService.signUp(email: email, password: password)
      self.user = user
      self.isLoggedIn = true
      self.errorMessage = nil
      return true
    } catch {
      self.isLoggedIn = false
      self.errorMessage = error.localizedDescription
      print("SignUp error: \(error)")
      return false
    }
  }

  @MainActor
  func signIn(email: String, password: String) async -> Bool {
    do {
      let user = try await authService.signIn(email: email, password: password)
      self.user = user
      self.isLoggedIn = true
      self.errorMessage = nil
      return true
    } catch {
      self.isLoggedIn = false
      self.errorMessage = error.localizedDescription
      print("SignIn error: \(error)")
      return false
    }
  }

  @MainActor
  func signOut() async {
    isSigningOut = true
    defer { isSigningOut = false }
    do {
      try await authService.signOut()
      self.user = nil
      self.isLoggedIn = false
      self.errorMessage = nil
      Self.removeUserFromUserDefaults()
    } catch {
      self.errorMessage = error.localizedDescription
      print("SignOut error: \(error)")
    }
  }

  // MARK: - UserDefaults保存/復元
  private func saveUserToUserDefaults() {
    guard let user = user else {
      Self.removeUserFromUserDefaults()
      return
    }
    if let data = try? JSONEncoder().encode(user) {
      UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
  }

  private static func loadUserFromUserDefaults() -> AppUser? {
    guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return nil }
    return try? JSONDecoder().decode(AppUser.self, from: data)
  }

  private static func removeUserFromUserDefaults() {
    UserDefaults.standard.removeObject(forKey: userDefaultsKey)
  }
}
