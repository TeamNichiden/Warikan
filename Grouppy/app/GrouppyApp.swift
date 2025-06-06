import SwiftUI
import SwiftData

@main
struct GrouppyApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: AppUser.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var navigationRouter = NavigationRouter()
    @StateObject private var authManager = AuthManager()
    @StateObject private var userDataService: UserDataService
    @StateObject private var homeViewModel: HomeViewModel
    
    init() {
        let userDataService = UserDataService(modelContext: ModelContext(try! ModelContainer(for: AppUser.self)))
        let homeViewModel = HomeViewModel(userDataService: userDataService)
        
        _userDataService = StateObject(wrappedValue: userDataService)
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigationRouter.path) {
            RootView()
                .environmentObject(authManager)
                .environmentObject(navigationRouter)
                .environmentObject(userDataService)
                .environmentObject(homeViewModel)
                .navigationDestination(for: Route.self) { destination in
                    switch destination {
                    case .home:
                        HomeView()
                    case .editProfile:  // 注意：RouteEnum.swift 中是 editProfile，不是 userProfile
                        UserProfile()
                    case .addEvent:
                        AddNewEventView()
                    case .eventList:
                        EventListView()
                    case .event(let id):
                        EventInfoView(eventId: id)
                    case .setting:
                        SettingView()
                        .toolbar(.hidden, for: .navigationBar)
                    case .history:
                        EmptyView()
                        .toolbar(.hidden, for: .navigationBar)
                    case .signUp:
                        SignupScreen()
                    }
                }
        }
        .environmentObject(navigationRouter)
        .environmentObject(homeViewModel)
        .environmentObject(userDataService)
        .onAppear {
            // 应用启动时检查登录状态
            homeViewModel.login()
        }
    }
}
