import SwiftUI

struct RootView: View {
  @EnvironmentObject var auth: AuthManager
  @EnvironmentObject var route: NavigationRouter

  var body: some View {
    if auth.isLoggedIn {
      HomeView()
        .environmentObject(route)
    } else {
      LoginScreen()
        .environmentObject(route)
    }
  }
}

#Preview {
  RootView()
    .environmentObject(AuthManager())
    .environmentObject(NavigationRouter())
}
