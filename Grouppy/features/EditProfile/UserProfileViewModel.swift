//
//  EditableProfileViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//
import SwiftUI

class UserProfileViewModel:ObservableObject {
    @Published var user: UserModel
    @Published var showDialog: Bool = false
    @Published var showCamera: Bool = false
    @Published var showLibrary: Bool = false
    
    init() {
        self.user = UserModel.sampleModel
    }
    
    func resetEmail() {
        
    }
    
    func resetPassword() {
        
    }
}
