//
//  GrouppyApp.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI

@main
struct GrouppyApp: App {
  @StateObject private var auth = AuthManager()
  @StateObject private var router = NavigationRouter()

  // BottomBarを表示したいRouteを列挙
    private let tabRoutes: [Route] = [.home, .eventList, .history, .setting]

  var body: some Scene {
    WindowGroup {
      VStack {
        NavigationStack(path: $router.path) {
          RootView()
            .environmentObject(auth)
            .environmentObject(router)
            .navigationDestination(for: Route.self) { route in
              switch route {
              case .home:
                HomeView()
                  .environmentObject(router)
                  .toolbar(.hidden, for: .navigationBar)
              case .editProfile:
                UserProfileView()
                  .environmentObject(router)
              case .addEvent:
                AddNewEventView()
                  .environmentObject(router)
              case .eventList:
                EventListView()
                  .environmentObject(router)
                  .toolbar(.hidden, for: .navigationBar)
              case .event(let id):
                EventInfoView(eventId: id)
                  .environmentObject(router)
              case .setting:
                  EmptyView()
                  .environmentObject(router)
                  .toolbar(.hidden, for: .navigationBar)
              case .history:
                EmptyView()
                  .environmentObject(router)
                  .toolbar(.hidden, for: .navigationBar)
              }
            }
        }
        if isShouldShowBottomBar {
          BottomNavBar(selected: router.path.last ?? .home)
            .environmentObject(router)
            .transition(.move(edge: .bottom))
        }
      }
    }
  }

  private var isShouldShowBottomBar: Bool {
    let current = router.path.last ?? .home
    return tabRoutes.contains(current)
  }
}
