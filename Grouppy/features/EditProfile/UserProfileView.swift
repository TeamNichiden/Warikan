//
//  EditableProfileView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct UserProfileView: View {
  @StateObject var vm = UserProfileViewModel()

  var body: some View {
    ScrollView {
      VStack {
        Text("アカウント編集")
          .fontWeight(.bold)
        ProfileIconSection
        Spacer()
        UserInfo(vm: vm)
        Spacer()
        SaveButtonSection
      }
    }
    .onTapGesture {
      hideKeyboard()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal)
    .scrollDismissesKeyboard(.interactively)
    .confirmationDialog("", isPresented: $vm.showIconChangeDialog, titleVisibility: .hidden) {
      Button {
        vm.showCameraSheet = true
      } label: {
        Text("カメラ")
      }
      Button {
        vm.showLibrarySheet = true
      } label: {
        Text("ライブラリ")
      }
      Button("キャンセル", role: .cancel) {
        vm.showIconChangeDialog = false
      }
    }
    .fullScreenCover(isPresented: $vm.showCameraSheet) {
      CameraView(icon: $vm.user.icon)
        .ignoresSafeArea()
    }
    .sheet(isPresented: $vm.showLibrarySheet) {
      PhotoLibraryView(icon: $vm.user.icon)
    }
    Spacer()
  }

  // MARK: - Subviews
  private var ProfileIconSection: some View {
    VStack {
      if let icon = vm.user.icon {
        Image(uiImage: icon)
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 100)
          .clipShape(Circle())
      } else {
        Circle()
          .fill(Color(.systemGray6))
          .frame(width: 100)
          .padding()
      }
      Button(action: {
        vm.showIconChangeDialog = true
      }) {
        Text("アイコンを変更")
          .font(.system(size: 14))
      }
    }
  }

  private var SaveButtonSection: some View {
    Button(action: { /*変えた情報をfirestoreに反映*/  }) {
      Text("変更を保存")
        .foregroundColor(Color.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(8)
    }
  }
}

#Preview {
  UserProfileView()
}
