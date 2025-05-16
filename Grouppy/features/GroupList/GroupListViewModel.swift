//
//  GroupListViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/15.
//
import SwiftUI

class GroupListViewModel: ObservableObject {
  private let repository: GroupRepository
  @Published var searchMessage: String = ""
  @Published var groupList: [Group] = []

  init(repository: GroupRepository = MockGroupRepository()) {
    self.repository = repository
    self.groupList = repository.fetchGroups()
  }

  var filteredGroupList: [Group] {
    if searchMessage.isEmpty {
      return groupList
    } else {
      return groupList.filter {
        $0.name.contains(searchMessage) || $0.description.contains(searchMessage)
      }
    }
  }
  // 本来はAPIやDBから取得する
}
