//
//  GroupViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//
import SwiftUI

class GroupViewModel: ObservableObject {
  @Published var mockTable = MockTableModel()
  @Published var group: MockGroupModel

  init(groupId: UUID) {
    if let found = MockGroupList.shared.groupList.first(where: { $0.id == groupId }) {
      self.group = found
    } else {
      self.group = MockGroupModel()
    }
  }
}
