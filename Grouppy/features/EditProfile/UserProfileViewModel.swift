//
//  EditableProfileViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//
import SwiftUI

class UserProfileViewModel:ObservableObject {
    @Published var user: UserModel
    
    init() {
        self.user = UserModel.sampleModel
    }
    
    func resetEmail() {
        
    }
    
    func resetPassword() {
        
    }
}
