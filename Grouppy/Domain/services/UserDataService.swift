import Foundation
import SwiftData
import SwiftUI

@MainActor
class UserDataService: ObservableObject {
    private var modelContext: ModelContext
    @Published var currentUser: AppUser?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        let descriptor = FetchDescriptor<AppUser>()
        do {
            let users = try modelContext.fetch(descriptor)
            currentUser = users.first
        } catch {
            print("Failed to load user: \(error)")
            currentUser = nil
        }
    }
    
    func saveUser(_ user: AppUser) {
        // 删除现有用户（因为我们只保存一个当前用户）
        deleteAllUsers()
        
        // 保存新用户
        modelContext.insert(user)
        
        do {
            try modelContext.save()
            currentUser = user
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    func updateUser(_ user: AppUser) {
        do {
            try modelContext.save()
            currentUser = user
        } catch {
            print("Failed to update user: \(error)")
        }
    }
    
    func logout() {
        deleteAllUsers()
        currentUser = nil
    }
    
    func loginWithMockDataIfNeeded() {
        if currentUser == nil {
            let mockUser = AppUser(
                id: MockData.authUser.id,
                name: MockData.authUser.name,
                email: MockData.authUser.email,
                userId: MockData.authUser.userId,
                iconUrl: MockData.authUser.iconUrl
            )
            saveUser(mockUser)
        }
    }
    
    private func deleteAllUsers() {
        do {
            try modelContext.delete(model: AppUser.self)
            try modelContext.save()
        } catch {
            print("Failed to delete users: \(error)")
        }
    }
}