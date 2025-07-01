import SwiftUI
import SwiftData

@main
struct GrouppyApp: App {
    // アプリ全体で使用するModelContainer（データベースコンテナ）を定義
    let modelContainer: ModelContainer
    
    init() {
        do {
            // AppUserモデル用のModelContainerを初期化
            modelContainer = try ModelContainer(for: AppUser.self)
        } catch {
            // ModelContainerの初期化に失敗した場合はアプリをクラッシュさせる（開発段階の想定）
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            // ContentViewにModelContainerを注入
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}

struct ContentView: View {
    // SwiftDataのModelContextを環境変数から取得
    @Environment(\.modelContext) private var modelContext
    // 画面遷移管理用のRouter
    @StateObject private var navigationRouter = NavigationRouter()
    // 認証状態管理用
    @StateObject private var authManager = AuthManager()
    // ユーザーデータ管理サービス
    @StateObject private var userDataService: UserDataService
    // ホーム画面用ViewModel
    @StateObject private var homeViewModel: HomeViewModel
    
    // StateObjectの初期化（依存関係の注入）
    init() {
        // ModelContainerを生成しUserDataServiceに渡す
        let userDataService = UserDataService(modelContext: ModelContext(try! ModelContainer(for: AppUser.self)))
        // HomeViewModelにUserDataServiceを渡して初期化
        let homeViewModel = HomeViewModel(userDataService: userDataService)
        
        // StateObjectにラップしてプロパティにセット
        _userDataService = StateObject(wrappedValue: userDataService)
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        // NavigationStackによる画面遷移の管理
        NavigationStack(path: $navigationRouter.path) {
            RootView()
            // 各種ViewModelやサービスを環境変数として注入
                .environmentObject(authManager)
                .environmentObject(navigationRouter)
                .environmentObject(userDataService)
                .environmentObject(homeViewModel)
            // Routeに応じた画面遷移先を定義
                .navigationDestination(for: Route.self) { destination in
                    switch destination {
                    case .home:
                        HomeView()
                    case .editProfile:
                        // RouteEnum.swiftではeditProfileが正しい（userProfileではない）ので注意
                        UserProfile()
                    case .addEvent:
                        AddNewEventView()
                    case .eventList:
                        EventListView()
                    case .event(let id):
                        EventInfoView(eventId: id)
                    case .setting:
                        SettingView()
                        // 設定画面ではナビゲーションバーを非表示
                            .toolbar(.hidden, for: .navigationBar)
                    case .history:
                        // 履歴画面もナビゲーションバーを非表示（将来拡張用のプレースホルダー）
                        EmptyView()
                            .toolbar(.hidden, for: .navigationBar)
                    case .signUp:
                        SignupScreen()
                    case .map:
                        MapView()
                    }
                }
        }
        // NavigationStack外でも環境変数としてViewModel等を注入
        .environmentObject(navigationRouter)
        .environmentObject(homeViewModel)
        .environmentObject(userDataService)
        .onAppear {
            // アプリ起動時にログイン状態を確認し、必要に応じて自動ログイン等を実行
            homeViewModel.login()
        }
    }
}
