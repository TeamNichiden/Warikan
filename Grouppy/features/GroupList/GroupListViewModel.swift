//
//  GroupListViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/15.
//
import SwiftUI

class GroupListViewModel: ObservableObject {
  @Published var searchMessage: String = ""
  @Published var groupList: [MockGroupModel] = MockGroupList.shared.groupList

  // 検索バーの入力に応じたフィルタ済みリスト
  var filteredGroupList: [MockGroupModel] {
    if searchMessage.isEmpty {
      return groupList
    } else {
      return groupList.filter { $0.groupName.contains(searchMessage) }
    }
  }
  // 本来はAPIやDBから取得する
}
