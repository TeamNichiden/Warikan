//
//  GroupListViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/15.
//
import SwiftUI

class GroupListViewModel: ObservableObject {
    @Published var searchMessage: String = ""
    @Published var groupList = MockGroupList.shared.groupList
    @Published var selectedGroupId: UUID? = nil
    @Published var isShowingGroupView = false
    @Published var navigationPath = NavigationPath()
    
    func showSelectedGroup(_ group: MockGroupModel) {
        selectedGroupId = group.id
        isShowingGroupView = true
//        navigationPath.append(AddGroupRoute.group(id: group.id))
    }
}
