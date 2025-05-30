//
//  SettingView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/30.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var route: NavigationRouter
    
    var body: some View {
        Button(action: {
            auth.isLoggedIn = false
            UserDefaults.standard.synchronize()
            route.popToRoot()
        }) {
            Text("log out")
        }
    }
}

#Preview {
    SettingView()
}
