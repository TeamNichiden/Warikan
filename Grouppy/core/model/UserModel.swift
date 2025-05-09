//
//  UserModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//
import SwiftUI

struct UserModel {
    let id = UUID()
    var name: String
    var userID: String
    var email: String
    var icon: Image?
    
    static let sampleModel = UserModel(name: "ユーザー名", userID: "userid", email: "user@example.com")
}
