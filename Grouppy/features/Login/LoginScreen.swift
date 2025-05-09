//
//  LoginScreen.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import SwiftUI

struct LoginScreen: View {
    @State private var showHomeView:Bool = false
    var body: some View {
        VStack {
            Text("ホーム画面へ")
                .onTapGesture {
                    showHomeView = true
                }
        }
        .fullScreenCover(isPresented: $showHomeView) {
            HomeView()
        }
    }
}

#Preview {
    LoginScreen()
}
