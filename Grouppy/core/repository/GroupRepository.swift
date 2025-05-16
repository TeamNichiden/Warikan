import Foundation

protocol GroupRepository {
  func fetchGroups() -> [Group]
  func addGroup(_ group: Group)
}

class MockGroupRepository: GroupRepository {
  func fetchGroups() -> [Group] {
    MockData.groups
  }
  func addGroup(_ group: Group) {
    MockData.groups.append(group)
  }
}
