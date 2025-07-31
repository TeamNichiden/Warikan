import SwiftUI
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var user: AppUser
    private var userDataService: UserDataService
    
    init(userDataService: UserDataService) {
        self.userDataService = userDataService
        
        // 如果没有保存的用户，使用 MockData
        if let savedUser = userDataService.currentUser {
            self.user = savedUser
        } else {
            userDataService.loginWithMockDataIfNeeded()
            self.user = userDataService.currentUser ?? AppUser(
                name: MockData.authUser.name,
                email: MockData.authUser.email,
                userId: MockData.authUser.userId,
                iconUrl: MockData.authUser.iconUrl
            )
        }
    }
    
    func updateUser(_ newUser: AppUser) {
        self.user = newUser
        userDataService.updateUser(newUser)
    }
    
    func updateUserWithImageData(_ imageData: Data?) {
        user.iconData = imageData
        userDataService.updateUser(user)
    }
    
    func logout() {
        userDataService.logout()
    }
    
    func login() {
        userDataService.loginWithMockDataIfNeeded()
        if let currentUser = userDataService.currentUser {
            self.user = currentUser
        }
    }
}
