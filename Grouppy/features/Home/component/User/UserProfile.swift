//
//  UserProfile.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var editedName: String = ""
    @State private var editedEmail: String = ""
    @State private var editedUserId: String = ""
    @State private var showingCameraPicker = false
    @State private var showingPhotoLibraryPicker = false
    @State private var showingActionSheet = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 20) {
            // ユーザーアイコン
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        )
                } else {
                    AsyncImage(url: homeViewModel.user.iconUrl) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                                )
                        case .failure(_):
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 100)
                        case .empty:
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 100)
                        @unknown default:
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            
            Button(action: {
                showingActionSheet = true
            }) {
                Text("アイコンを変更")
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("アイコンを選択"),
                    message: Text("写真の取得方法を選択してください"),
                    buttons: [
                        .default(Text("カメラ")) {
                            showingCameraPicker = true
                        },
                        .default(Text("フォトライブラリ")) {
                            showingPhotoLibraryPicker = true
                        },
                        .cancel(Text("キャンセル"))
                    ]
                )
            }
            // 相机使用 fullScreenCover
            .fullScreenCover(isPresented: $showingCameraPicker) {
                ImagePickerView(
                    selectedImage: $selectedImage,
                    sourceType: .camera
                )
                .ignoresSafeArea()
            }
            // 相册使用 sheet（无视全局）
            .sheet(isPresented: $showingPhotoLibraryPicker) {
                ImagePickerView(
                    selectedImage: $selectedImage,
                    sourceType: .photoLibrary
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
            
            // 编辑表单
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("名前")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("名前を入力してください", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ユーザーID")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("ユーザーIDを入力してください", text: $editedUserId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("メールアドレス")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("メールアドレスを入力してください", text: $editedEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Button("保存") {
                    saveChanges()
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("プロフィール")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadUserData()
        }
        // 点击空白区域隐藏键盘
        .onTapGesture {
            hideKeyboard()
        }
        // 键盘无视布局
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func loadUserData() {
        editedName = homeViewModel.user.name
        editedEmail = homeViewModel.user.email
        editedUserId = homeViewModel.user.userId
    }
    
    private func saveChanges() {
        // 入力検証
        guard !editedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !editedUserId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !editedEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        // 更新されたユーザーオブジェクトを作成
        let updatedUser = AppUser(
            id: homeViewModel.user.id,
            name: editedName.trimmingCharacters(in: .whitespacesAndNewlines),
            email: editedEmail.trimmingCharacters(in: .whitespacesAndNewlines),
            userId: editedUserId.trimmingCharacters(in: .whitespacesAndNewlines),
            iconUrl: homeViewModel.user.iconUrl
        )
        
        // HomeViewModelのユーザーデータを更新
        homeViewModel.updateUser(updatedUser)
    }
    
    // 隐藏键盘的辅助函数
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// ImagePickerViewの実装
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    NavigationView {
        UserProfile()
            .environmentObject(HomeViewModel())
    }
}
