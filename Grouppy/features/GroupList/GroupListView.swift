//
//  GroupListView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

struct GroupListView: View {
  @StateObject var vm = GroupListViewModel()
  @EnvironmentObject var route: NavigationRouter

  var body: some View {
    VStack {
      // ヘッダー部分
      headerView

      // 検索バー
      searchBar

      // グループリスト
      groupListView
    }
    .padding(.horizontal)
    .onTapGesture {
      hideKeyboard()
    }
  }

  // MARK: - Subviews

  private var headerView: some View {
    HStack {
      Spacer()
      Button(action: {
        route.navigate(to: .addGroup)
      }) {
        addButton()
      }
    }
    .padding(.bottom)
  }

  private var searchBar: some View {
    TextField("検索", text: $vm.searchMessage)
      .padding()
      .background(Color(.systemGray6))
      .cornerRadius(16)
  }

  private var groupListView: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 16) {
        if !vm.groupList.isEmpty {
          ForEach(vm.groupList) { group in
            groupRow(for: group)
          }
        } else {
          Text("現在はグループがありません")
            .foregroundColor(.gray)
        }
      }
    }
  }

  private func groupRow(for group: MockGroupModel) -> some View {
    Button(action: {
      route.navigate(to: .group(id: group.id))
    }) {
      HStack {
        Image(systemName: "person.3.fill")  // 仮のグループアイコン
        Text(group.groupName)
      }
      .padding()
      .frame(maxWidth: .infinity, minHeight: 50)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 1)
          .opacity(0.1)
      )
      .padding(.horizontal)
    }
  }
}

#Preview {
  GroupListView()
}
