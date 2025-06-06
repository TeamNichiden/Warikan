//
//  HomeViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var user: AppUser
    
    init() {
        self.user = MockData.authUser
    }
    
    func updateUser(_ newUser: AppUser) {
        self.user = newUser
    }
}
