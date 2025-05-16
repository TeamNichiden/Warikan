//
//  GroupViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//
import SwiftUI

class GroupViewModel: ObservableObject {
  @Published var group: Group
  private let repository: GroupRepository

  init(groupId: String, repository: GroupRepository = MockGroupRepository()) {
    self.repository = repository
    if let found = repository.fetchGroups().first(where: { $0.id == groupId }) {
      self.group = found
    } else {
      // 空のGroupを生成（適宜修正）
      self.group = Group(
        id: groupId, name: "", description: "", ownerId: "", memberIds: [], eventIds: [],
        createdAt: Date(), updatedAt: Date())
    }
  }
}
