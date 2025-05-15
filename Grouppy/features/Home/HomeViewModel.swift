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
    
    func goToGroupListView() {
        navigationPath.append(AddRoute.groupList)
    }
}
