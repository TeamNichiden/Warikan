//
//  HomeView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI

struct HomeView: View {
  @StateObject var vm = HomeViewModel()
  @EnvironmentObject var route: NavigationRouter
  @EnvironmentObject var auth: AuthManager

  var body: some View {
    VStack {

      //MARK: HEADER
      HStack {
        MiniProfile(user: MockData.authUser)
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemGray6).opacity(0.6))
      .cornerRadius(10)
      .overlay(alignment: .topTrailing) {
        Button {
          route.navigate(to: .editProfile)
        } label: {
          Text("編集")
            .underline()
            .padding()
        }
      }

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

      Spacer()

      //MARK: FOOTER
      VStack(alignment: .leading) {
        Text("グループ管理")
          .font(.title2)
          .fontWeight(.bold)
          .padding()

        GroupCard(
          action: { route.navigate(to: .addEvent) },
          btnImg: "plus.circle.fill",
          title: "グループ作成",
          message: "新しいグループを作成する"
        )

        GroupCard(
          action: { route.navigate(to: .eventList) },
          btnImg: "list.dash",
          title: "グループ確認",
          message: "所属グループを確認する"
        )
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
  }
}

#Preview {
  NavigationStack {
    HomeView()
  }
}
