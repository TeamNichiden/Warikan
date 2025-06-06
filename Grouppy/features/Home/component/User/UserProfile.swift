//
//  EditableProfileView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var vm: UserProfileViewModel
    @EnvironmentObject var homeVM: HomeViewModel // 接收HomeViewModel
    
    init() {
        let viewModel = UserProfileViewModel()
        self._vm = StateObject(wrappedValue: viewModel)
    }
    
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
        .onAppear {
            // 设置用户数据和回调
            vm.user = homeVM.user
            vm.onUserUpdate = { updatedUser in
                homeVM.updateUser(updatedUser)
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
            CameraView(
                icon: .constant(nil),
                onImagePicked: { image in
                    vm.updateIcon(with: image)
                }
            )
            .ignoresSafeArea()
        }
        .sheet(isPresented: $vm.showLibrarySheet) {
            PhotoLibraryView(
                icon: .constant(nil),
                onImagePicked: { image in
                    vm.updateIcon(with: image)
                })
        }
        Spacer()
    }
    
    // MARK: - Subviews
    private var ProfileIconSection: some View {
        VStack {
            if let url = vm.user.iconUrl {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color(.systemGray6))
                        .frame(width: 100)
                }
            } else {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 100)
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
        Button(action: {
            vm.updateUserInfo()
        }) {
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
