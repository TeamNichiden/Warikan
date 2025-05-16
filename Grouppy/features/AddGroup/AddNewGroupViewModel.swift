//
//  AddNewGroupViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import Foundation

class AddNewGroupViewModel: ObservableObject {
  @Published var group = Group(
    id: UUID().uuidString, name: "", description: "", ownerId: "", memberIds: [], eventIds: [],
    createdAt: Date(), updatedAt: Date())
  @Published var isShowGroup: Bool = false
  // TODO: 下記のプロパティはイベント追加画面で使用するが一旦コメントアウトで対応
  //  @Published var selectedDate = Date()
  //  @Published var showDatePicker: Bool = false
  @Published var lastGroupId: String?
  private let repository: GroupRepository

  init(repository: GroupRepository = MockGroupRepository()) {
    self.repository = repository
  }

  func isCheckingInfo() {
    if !group.name.isEmpty {
      addGroup()
      isShowGroup = true
    }
  }

  func addGroup() {
    let newGroup = group
    repository.addGroup(newGroup)
    lastGroupId = newGroup.id
    group = Group(
      id: UUID().uuidString, name: "", description: "", ownerId: "", memberIds: [], eventIds: [],
      createdAt: Date(), updatedAt: Date())
  }
}
