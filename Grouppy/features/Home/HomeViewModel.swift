//
//  HomeViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func goToEdit() {
        navigationPath.append(AddRoute.editProfile)
    }
    
    func goToAddNewGroup() {
        navigationPath.append(AddRoute.addNewGroup)
    }
    // MARK: TEST
    func checkList() {
        for group in MockGroupList.shared.groupList {
            print(group.groupName)
        }
    }
}
