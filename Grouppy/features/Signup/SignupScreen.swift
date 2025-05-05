//
//  SignupScreen.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import SwiftUI

struct SignupScreen: View {
    @StateObject private var vm = SignupViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("アカウント作成")
                    .font(.headline)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding(.top, 16)
            
            Spacer().frame(height: 16)
            
            // ロゴ
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                Text("App")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
            }
            .padding(.bottom, 8)
            
            Text("新規アカウント登録")
                .font(.title3).bold()
                .padding(.bottom, 2)
            Text("以下の情報を入力してください")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            
            Group {
                TextField("メールアドレス", text: $vm.uiState.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 8)
                ZStack(alignment: .trailing) {
                    if vm.uiState.isPasswordVisible {
                        TextField("パスワード", text: $vm.uiState.password)
                    } else {
                        SecureField("パスワード", text: $vm.uiState.password)
                    }
                    Button(action: { vm.uiState.isPasswordVisible.toggle() }) {
                        Text(vm.uiState.isPasswordVisible ? "非表示" : "表示")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }
                    .padding(.trailing, 12)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 8)
                SecureField("パスワード確認", text: $vm.uiState.passwordConfirm)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center) {
                    Button(action: { vm.uiState.isAgreedTerms.toggle() }) {
                        Image(systemName: vm.uiState.isAgreedTerms ? "checkmark.square" : "square")
                            .foregroundColor(.black)
                    }
                    Button(action: { vm.uiState.showTerms = true }) {
                        Text("利用規約")
                            .foregroundColor(.blue)
                            .underline()
                    }
                    Text("に同意する")
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack(alignment: .center) {
                    Button(action: { vm.uiState.isAgreedPrivacy.toggle() }) {
                        Image(systemName: vm.uiState.isAgreedPrivacy ? "checkmark.square" : "square")
                            .foregroundColor(.black)
                    }
                    Button(action: { vm.uiState.showPrivacy = true }) {
                        Text("プライバシーポリシー")
                            .foregroundColor(.blue)
                            .underline()
                    }
                    Text("に同意する")
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            .padding(.vertical, 8)
            
            Button(action: {
                if vm.validatePassword() {
                    // TODO: Implement signup action
                } else {
                    vm.uiState.isAlertPresented = true
                    vm.uiState.passwordConfirm = ""
                }
            }) {
                Text("登録する")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((vm.uiState.isAgreedTerms && vm.uiState.isAgreedPrivacy) ? Color.blue : Color.gray)
                    .cornerRadius(20)
            }
            .disabled(!(vm.uiState.isAgreedTerms && vm.uiState.isAgreedPrivacy))
            .padding(.top, 12)
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(.systemGray4))
                Text("または")
                    .font(.caption)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(.systemGray4))
            }
            .padding(.vertical, 16)
            
            Button(action: { /* Google認証 */ }) {
                HStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 24, height: 24)
                        .overlay(Image(systemName: "globe").foregroundColor(.blue))
                    Text("Googleで続ける")
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .cornerRadius(20)
            }
            .padding(.bottom, 8)
            Button(action: { /* Apple認証 */ }) {
                HStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 24, height: 24)
                        .overlay(Image(systemName: "applelogo").foregroundColor(.white))
                    Text("Appleで続ける")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(20)
            }
            
            Spacer()
            HStack(spacing: 4) {
                Text("すでにアカウントをお持ちですか？")
                    .foregroundColor(.gray)
                    .font(.footnote)
                Button(action: { /* ログイン画面へ */ }) {
                    Text("ログイン")
                        .foregroundColor(.blue)
                        .font(.footnote)
                        .underline()
                }
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $vm.uiState.isAlertPresented) {
            Alert(title: Text("エラー"), message: Text("パスワードが一致しません"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $vm.uiState.showTerms) {
            VStack {
                Text("利用規約")
                    .font(.title2).bold()
                    .padding()
                ScrollView {
                    Text("ここに利用規約の内容を記載。\n\n（またはWebViewでURLを開く実装）")
                        .padding()
                }
                Button("閉じる") { vm.uiState.showTerms = false }
                    .padding()
            }
        }
        .sheet(isPresented: $vm.uiState.showPrivacy) {
            VStack {
                Text("プライバシーポリシー")
                    .font(.title2).bold()
                    .padding()
                ScrollView {
                    Text("ここにプライバシーポリシーの内容を記載。\n\n（またはWebViewでURLを開く実装）")
                        .padding()
                }
                Button("閉じる") { vm.uiState.showPrivacy = false }
                    .padding()
            }
        }
    }
}

#Preview {
    SignupScreen()
}
