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
      .cornerRadius(8)
      .overlay(alignment: .trailing) {
        Button {
          route.navigate(to: .editProfile)
        } label: {
            Text("編集")
                .foregroundColor(.black)
                .padding(8)
                .padding(.horizontal,12)
                .background(Color(.systemGray5))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        .padding()
      }

      Spacer()

      //MARK: FOOTER
      HStack(spacing: 16) {
          GroupCard(
              action: { route.navigate(to: .addEvent) },
              title: "イベント作成",
              textColor: .white,
              backgroundColor: .blue
          )
          .overlay(
              RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.blue, lineWidth: 2)
          )
          .frame(maxWidth: .infinity)
          
          GroupCard(
              action: { route.navigate(to: .eventList) },
              title: "イベント確認",
              textColor: .blue,
              backgroundColor: .white
          )
          .overlay(
              RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.blue, lineWidth: 2)
          )
          .frame(maxWidth: .infinity)
      }
      .frame(maxWidth: .infinity)
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
