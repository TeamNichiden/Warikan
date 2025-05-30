//
//  EditableProfileViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//
import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var user: AppUser
  @Published var showIconChangeDialog: Bool = false
  @Published var showCameraSheet: Bool = false
  @Published var showLibrarySheet: Bool = false
  private let imageUploadService: ImageUploadService

    init(user: AppUser? = nil, imageUploadService: ImageUploadService = LocalImageUploadService()) {
    self.imageUploadService = imageUploadService
    if let user = user {
      self.user = user
    } else {
        self.user = AppUser(id: UUID(), name: "", email: "", userId: "", iconUrl: nil)
    }
  }

  func updateIcon(with image: UIImage) {
    imageUploadService.uploadImage(image) { [weak self] url in
      DispatchQueue.main.async {
        self?.user.iconUrl = url
      }
    }
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
