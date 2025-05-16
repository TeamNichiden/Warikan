//
//  EditableUserInfoView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct UserInfo: View {
  //MARK: TEST
  @State private var password: String = "******"

  @ObservedObject var vm: UserProfileViewModel

  var body: some View {
    VStack {
      InfoRow(title: "ニックネーム", inputText: $vm.user.name)
      InfoRow(title: "アカウントID", inputText: $vm.user.userID)
      InfoRow(
        title: "メールアドレス", inputText: $vm.user.email, isEditable: false, submitLabel: "再設定",
        submitAction: vm.resetEmail)
      InfoRow(
        title: "パスワード", inputText: $password, isEditable: false, submitLabel: "再設定",
        submitAction: vm.resetPassword)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 25)
    .overlay(
      RoundedRectangle(cornerRadius: 13)
        .stroke(lineWidth: 1).opacity(0.1)
    )
  }
}

#Preview {
  UserInfo(vm: UserProfileViewModel())
}
