//
//  GrouppyApp.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI

@main
struct GrouppyApp: App {
  @StateObject private var router = NavigationRouter()
  var body: some Scene {
    WindowGroup {
      LoginScreen()
        .environmentObject(router)
    }
  }
}
