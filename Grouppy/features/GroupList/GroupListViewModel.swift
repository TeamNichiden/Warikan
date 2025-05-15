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

}
