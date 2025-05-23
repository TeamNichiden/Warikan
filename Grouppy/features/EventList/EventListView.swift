//
//  GroupListView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

struct EventListView: View {
  @StateObject var vm = EventListViewModel()
  @EnvironmentObject var route: NavigationRouter

  var body: some View {
    VStack {
      // ヘッダー部分
      headerView

      // 検索バー
      searchBar

      // イベントリスト
      eventListView
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
        route.navigate(to: .addEvent)
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

  private var eventListView: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 16) {
        if !vm.filteredEventList.isEmpty {
          ForEach(vm.filteredEventList) { event in
            eventRow(for: event)
          }
        } else {
          Text("現在はイベントがありません")
            .foregroundColor(.gray)
        }
      }
    }
  }

  private func eventRow(for event: Event) -> some View {
    Button(action: {
      route.navigate(to: .event(id: event.id))
    }) {
      HStack {
        Image(systemName: "calendar")
        Text(event.title)
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
  EventListView()
}
