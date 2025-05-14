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
                
                if let  icon = vm.user.icon {
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
                    vm.showDialog = true
                }) {
                    Text("アイコンを変更")
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                UserInfo(vm: vm)
                
                Spacer()
                
                Button(action: { /*変えた情報をfirestoreに反映*/ }) {
                    Text("変更を保存")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .scrollDismissesKeyboard(.interactively)
        .confirmationDialog("", isPresented: $vm.showDialog, titleVisibility: .hidden) {
            Button {
                vm.showCamera = true
            } label: {
                Text("カメラ")
            }
            
            Button {
                vm.showLibrary = true
            } label: {
                Text("ライブラリ")
            }

            Button("キャンセル",role: .cancel) {
                vm.showDialog = false
            }
        }
        .fullScreenCover(isPresented: $vm.showCamera) {
            CameraView(icon: $vm.user.icon)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $vm.showLibrary) {
            PhotoLibraryView(icon: $vm.user.icon)
        }
        Spacer()
    }
}

#Preview {
    UserProfileView()
}
