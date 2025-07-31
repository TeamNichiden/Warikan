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
          Task {
            await auth.signOut()
            route.popToRoot()
          }
        }) {
          if auth.isSigningOut {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle())
          } else {
            Text("ログアウト")
          }
        }
        .disabled(auth.isSigningOut)
    }
}

#Preview {
    SettingView()
}
