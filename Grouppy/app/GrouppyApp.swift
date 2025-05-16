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
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.path) {
        Group {
          if auth.isLoggedIn {
            HomeView()
              .environmentObject(router)
          } else {
            LoginScreen()
              .environmentObject(router)
          }
        }
        .navigationDestination(for: Route.self) { route in
          switch route {
          case .editProfile:
            UserProfileView()
              .environmentObject(router)
          case .addGroup:
            AddNewGroupView()
              .environmentObject(router)
          case .groupList:
            GroupListView()
              .environmentObject(router)
          case .group(let id):
            GroupView(groupId: id)
              .environmentObject(router)
          }
        }
      }
    }
  }
}
