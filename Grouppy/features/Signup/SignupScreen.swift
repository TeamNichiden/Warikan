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
        ScrollView {
            
            VStack(spacing: 0) {
                Text("新規アカウント作成")
                    .font(.title)
                    .bold()
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
                .padding(.bottom, 16)
                
                Text("以下の情報を入力してください")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                
                // 入力欄
                SignupInputFields(
                    name: $vm.uiState.name,
                    email: $vm.uiState.email,
                    password: $vm.uiState.password,
                    passwordConfirm: $vm.uiState.passwordConfirm,
                    isPasswordVisible: $vm.uiState.isPasswordVisible
                )
                
                // 同意セクション
                AgreementSection(
                    isAgreedTerms: $vm.uiState.isAgreedTerms,
                    isAgreedPrivacy: $vm.uiState.isAgreedPrivacy,
                    onShowTerms: { vm.uiState.showTerms = true },
                    onShowPrivacy: { vm.uiState.showPrivacy = true }
                )
                
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
                        .background(
                            (vm.uiState.isAgreedTerms && vm.uiState.isAgreedPrivacy) ? Color.blue : Color.gray
                        )
                        .cornerRadius(8)
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
                
                // ソーシャル認証ボタン
                SocialAuthButtons(
                    onGoogle: { /* Google認証 */  },
                    onApple: { /* Apple認証 */  }
                )
                
                Spacer()
                HStack(spacing: 4) {
                    Text("すでにアカウントをお持ちですか？")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Button(action: { /* ログイン画面へ */  }) {
                        Text("ログイン")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.footnote)
                            .underline()
                    }
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $vm.uiState.isAlertPresented) {
            Alert(title: Text("エラー"), message: Text("パスワードが一致しません"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $vm.uiState.showTerms) {
            TermsSheetView(onClose: { vm.uiState.showTerms = false })
        }
        .sheet(isPresented: $vm.uiState.showPrivacy) {
            PrivacySheetView(onClose: { vm.uiState.showPrivacy = false })
        }
    }
}

struct SignupInputFields: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirm: String
    @Binding var isPasswordVisible: Bool
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            Text("お名前")
            TextField("例：山田　太郎", text: $name)
                .inputRowStyle()
            Text("Eメールアドレス")
            TextField("例：yamada@example.com".rawValue, text: $email)
                .inputRowStyle()
            Text("パスワード")
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("8文字以上の英数字", text: $password)
                } else {
                    SecureField("8文字以上の英数字", text: $password)
                }
                
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 12)
            }
            .inputRowStyle()
            Text("パスワード(確認)")
            SecureField("パスワードを再入力", text: $passwordConfirm)
                .inputRowStyle()
        }
    }
}

struct AgreementSection: View {
    @Binding var isAgreedTerms: Bool
    @Binding var isAgreedPrivacy: Bool
    var onShowTerms: () -> Void
    var onShowPrivacy: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Button(action: { isAgreedTerms.toggle() }) {
                    Image(systemName: isAgreedTerms ? "checkmark.square" : "square")
                        .foregroundColor(.black)
                }
                Button(action: onShowTerms) {
                    Text("利用規約")
                        .foregroundColor(.blue)
                        .underline()
                }
                Text("に同意する")
                    .foregroundColor(.black)
                Spacer()
            }
            HStack(alignment: .center) {
                Button(action: { isAgreedPrivacy.toggle() }) {
                    Image(systemName: isAgreedPrivacy ? "checkmark.square" : "square")
                        .foregroundColor(.black)
                }
                Button(action: onShowPrivacy) {
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
    }
}

struct SocialAuthButtons: View {
    var onGoogle: () -> Void
    var onApple: () -> Void
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onApple) {
                Image(systemName: "apple.logo")
                    .foregroundColor(.black)
                    .font(.title)
            }
            Button(action: onGoogle) {
                Text("G")
            }
        }
    }
}

struct TermsSheetView: View {
    var onClose: () -> Void
    var body: some View {
        VStack {
            Text("利用規約")
                .font(.title2).bold()
                .padding()
            ScrollView {
                Text("ここに利用規約の内容を記載。\n\n（またはWebViewでURLを開く実装）")
                    .padding()
            }
            Button("閉じる", action: onClose)
                .padding()
        }
    }
}

struct PrivacySheetView: View {
    var onClose: () -> Void
    var body: some View {
        VStack {
            Text("プライバシーポリシー")
                .font(.title2).bold()
                .padding()
            ScrollView {
                Text("ここにプライバシーポリシーの内容を記載。\n\n（またはWebViewでURLを開く実装）")
                    .padding()
            }
            Button("閉じる", action: onClose)
                .padding()
        }
    }
}

extension View {
    func inputRowStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.bottom, 8)
    }
}

#Preview {
    SignupScreen()
}
