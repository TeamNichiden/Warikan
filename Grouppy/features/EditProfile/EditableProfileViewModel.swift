//
//  EditableProfileViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//
import SwiftUI

class EditableProfileViewModel:ObservableObject {
    @Published var editUser: UserModel
    
    init() {
        self.editUser = UserModel.sampleModel
    }
    
    func resetEmail() {
        
    }
    
    func resetPassword() {
        
    }
}
