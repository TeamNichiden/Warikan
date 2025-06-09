//
//  MainTabView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/06.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("ホーム")
                }
            
            FriendListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("フレンド")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("設定")
                }
        }
    }
}

#Preview {
    MainTabView()
}
