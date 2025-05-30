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
        RootView()
          .environmentObject(auth)
          .environmentObject(router)
          .navigationDestination(for: Route.self) { route in
            switch route {
            case .home:
              HomeView()
                .environmentObject(router)
            case .editProfile:
              UserProfileView()
                .environmentObject(router)
            case .addEvent:
              AddNewEventView()
                .environmentObject(router)
            case .eventList:
              EventListView()
                .environmentObject(router)
            case .event(let id):
                EventInfoView(eventId: id)
                .environmentObject(router)
            }
          }
      }
    }
  }
}
