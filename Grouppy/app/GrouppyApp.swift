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
            .navigationDestination(for: Route.self) { route in
              switch route {
              case .home:
                HomeView()
                  .toolbar(.hidden, for: .navigationBar)
              case .editProfile:
                UserProfileView()
              case .addEvent:
                AddNewEventView()
              case .eventList:
                EventListView()
                  .toolbar(.hidden, for: .navigationBar)
              case .event(let id):
                EventInfoView(eventId: id)
              case .setting:
                EmptyView()
                  .toolbar(.hidden, for: .navigationBar)
              case .history:
                EmptyView()
                  .toolbar(.hidden, for: .navigationBar)
              }
            }
        }
        if isShouldShowBottomBar {
          BottomNavBar(selected: router.path.last ?? .home)
            .transition(.move(edge: .bottom))
        }
      }
      .environmentObject(auth)
      .environmentObject(router)
    }
  }

  private var isShouldShowBottomBar: Bool {
    let current = router.path.last ?? .home
    return tabRoutes.contains(current)
  }
}
