//
//  EditableProfileViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//
import SwiftUI

class UserProfileViewModel: ObservableObject {
  @Published var user: UserModel
  @Published var showIconChangeDialog: Bool = false
  @Published var showCameraSheet: Bool = false
  @Published var showLibrarySheet: Bool = false

  init(user: UserModel = UserModel.sampleModel) {
    self.user = user
  }

  func resetEmail() {
    // TODO: メールアドレス再設定処理
  }

  func resetPassword() {
    // TODO: パスワード再設定処理
  }

  func saveProfile() {
    // TODO: プロフィール保存処理
  }
}
