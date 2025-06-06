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
        GeometryReader { geometry in
            let screenSize = UIScreen.main.bounds.size // 使用固定的屏幕尺寸
            let fixedGeometry = FixedGeometry(width: screenSize.width, height: screenSize.height)
            
            ScrollView {
                VStack(spacing: fixedGeometry.height * 0.02) { // 2% 屏幕高度作为间距
                    Text("新規アカウント作成")
                        .font(.system(size: fixedGeometry.width * 0.07)) // 7% 屏幕宽度作为字体大小
                        .bold()
                        .padding(.top, fixedGeometry.height * 0.02)
                    
                    // ロゴ
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(
                                width: fixedGeometry.width * 0.2,
                                height: fixedGeometry.width * 0.2
                            )
                        Text("App")
                            .foregroundColor(.white)
                            .font(.system(size: fixedGeometry.width * 0.06))
                            .bold()
                    }
                    .padding(.bottom, fixedGeometry.height * 0.02)
                    
                    Text("以下の情報を入力してください")
                        .font(.system(size: fixedGeometry.width * 0.04))
                        .foregroundColor(.gray)
                        .padding(.bottom, fixedGeometry.height * 0.02)
                    
                    // 入力欄
                    SignupInputFields(
                        name: $vm.uiState.name,
                        email: $vm.uiState.email,
                        password: $vm.uiState.password,
                        passwordConfirm: $vm.uiState.passwordConfirm,
                        isPasswordVisible: $vm.uiState.isPasswordVisible,
                        fixedGeometry: fixedGeometry
                    )
                    
                    // 同意セクション
                    AgreementSection(
                        isAgreedTerms: $vm.uiState.isAgreedTerms,
                        isAgreedPrivacy: $vm.uiState.isAgreedPrivacy,
                        onShowTerms: { vm.uiState.showTerms = true },
                        onShowPrivacy: { vm.uiState.showPrivacy = true },
                        fixedGeometry: fixedGeometry
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
                            .font(.system(size: fixedGeometry.width * 0.045))
                            .frame(maxWidth: .infinity)
                            .frame(height: fixedGeometry.height * 0.06)
                            .background(
                                (vm.uiState.isAgreedTerms && vm.uiState.isAgreedPrivacy) ? Color.blue : Color.gray
                            )
                            .cornerRadius(fixedGeometry.width * 0.02)
                    }
                    .disabled(!(vm.uiState.isAgreedTerms && vm.uiState.isAgreedPrivacy))
                    .padding(.top, fixedGeometry.height * 0.015)
                    
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(.systemGray4))
                        Text("または")
                            .font(.system(size: fixedGeometry.width * 0.035))
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(.systemGray4))
                    }
                    .padding(.vertical, fixedGeometry.height * 0.02)
                    
                    // ソーシャル認証ボタン
                    SocialAuthButtons(
                        onGoogle: { /* Google認証 */  },
                        onApple: { /* Apple認証 */  },
                        fixedGeometry: fixedGeometry
                    )
                    
                    Spacer().frame(height: fixedGeometry.height * 0.02)
                    
                    HStack(spacing: fixedGeometry.width * 0.01) {
                        Text("すでにアカウントをお持ちですか？")
                            .foregroundColor(.gray)
                            .font(.system(size: fixedGeometry.width * 0.035))
                        Button(action: { /* ログイン画面へ */  }) {
                            Text("ログイン")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.system(size: fixedGeometry.width * 0.035))
                                .underline()
                        }
                    }
                    .padding(.bottom, fixedGeometry.height * 0.02)
                }
                .padding(.horizontal, fixedGeometry.width * 0.06) // 6% 屏幕宽度作为水平间距
                .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture {
                hideKeyboard()
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
}

struct SignupInputFields: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirm: String
    @Binding var isPasswordVisible: Bool
    let fixedGeometry: FixedGeometry
    
    var body: some View {
        VStack(alignment:.leading, spacing: fixedGeometry.height * 0.015) {
            Text("お名前")
                .font(.system(size: fixedGeometry.width * 0.04))
            TextField("例：山田　太郎", text: $name)
                .inputRowStyle(fixedGeometry: fixedGeometry)
            
            Text("Eメールアドレス")
                .font(.system(size: fixedGeometry.width * 0.04))
            TextField("例：yamada@example.com".lowercased(), text: $email)
                .inputRowStyle(fixedGeometry: fixedGeometry)
            
            Text("パスワード")
                .font(.system(size: fixedGeometry.width * 0.04))
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("8文字以上の英数字", text: $password)
                } else {
                    SecureField("8文字以上の英数字", text: $password)
                }
                
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                        .font(.system(size: fixedGeometry.width * 0.04))
                }
                .padding(.trailing, fixedGeometry.width * 0.03)
            }
            .inputRowStyle(fixedGeometry: fixedGeometry)
            
            Text("パスワード(確認)")
                .font(.system(size: fixedGeometry.width * 0.04))
            SecureField("パスワードを再入力", text: $passwordConfirm)
                .inputRowStyle(fixedGeometry: fixedGeometry)
        }
    }
}

struct AgreementSection: View {
    @Binding var isAgreedTerms: Bool
    @Binding var isAgreedPrivacy: Bool
    var onShowTerms: () -> Void
    var onShowPrivacy: () -> Void
    let fixedGeometry: FixedGeometry
    
    var body: some View {
        VStack(alignment: .leading, spacing: fixedGeometry.height * 0.01) {
            HStack(alignment: .center) {
                Image(systemName: isAgreedTerms ? "checkmark.square" : "square")
                    .foregroundColor(.black)
                    .font(.system(size: fixedGeometry.width * 0.05))
                    .onTapGesture {
                        isAgreedTerms.toggle()
                    }
                Button(action: onShowTerms) {
                    Text("利用規約")
                        .foregroundColor(.blue)
                        .font(.system(size: fixedGeometry.width * 0.04))
                        .underline()
                }
                Text("に同意する")
                    .foregroundColor(.black)
                    .font(.system(size: fixedGeometry.width * 0.04))
                Spacer()
            }
            HStack(alignment: .center) {
                    Image(systemName: isAgreedPrivacy ? "checkmark.square" : "square")
                        .foregroundColor(.black)
                        .font(.system(size: fixedGeometry.width * 0.05))
                        .onTapGesture {
                            isAgreedPrivacy.toggle()
                        }
                Button(action: onShowPrivacy) {
                    Text("プライバシーポリシー")
                        .foregroundColor(.blue)
                        .font(.system(size: fixedGeometry.width * 0.04))
                        .underline()
                }
                Text("に同意する")
                    .foregroundColor(.black)
                    .font(.system(size: fixedGeometry.width * 0.04))
                Spacer()
            }
        }
        .padding(.vertical, fixedGeometry.height * 0.01)
    }
}

struct SocialAuthButtons: View {
    var onGoogle: () -> Void
    var onApple: () -> Void
    let fixedGeometry: FixedGeometry
    
    var body: some View {
        HStack(spacing: fixedGeometry.width * 0.04) {
            Button(action: onApple) {
                HStack(spacing: fixedGeometry.width * 0.02) {
                    Image(systemName: "apple.logo")
                        .foregroundColor(.white)
                        .font(.system(size: fixedGeometry.width * 0.05))
                    Text("Appleでサインアップ")
                        .foregroundColor(.white)
                        .font(.system(size: fixedGeometry.width * 0.04))
                }
                .frame(maxWidth: .infinity)
                .frame(height: fixedGeometry.height * 0.06)
                .background(Color.black)
                .cornerRadius(fixedGeometry.width * 0.02)
            }
            
            Button(action: onGoogle) {
                HStack(spacing: fixedGeometry.width * 0.02) {
                    Image(.googleOld)
                        .resizable()
                        .scaledToFit()
                        .frame(width: fixedGeometry.width * 0.05)
                    Text("Googleでサインアップ")
                        .foregroundColor(.black)
                        .font(.system(size: fixedGeometry.width * 0.04))
                }
                .frame(maxWidth: .infinity)
                .frame(height: fixedGeometry.height * 0.06)
                .background(Color.white)
                .cornerRadius(fixedGeometry.width * 0.02)
                .overlay(
                    RoundedRectangle(cornerRadius: fixedGeometry.width * 0.02)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            }
        }
    }
}

struct TermsSheetView: View {
    var onClose: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("利用規約")
                    .font(.system(size: geometry.size.width * 0.06))
                    .bold()
                    .padding(geometry.size.height * 0.02)
                ScrollView {
                    Text("ここに利用規約の内容を記載。\n\n（またはWebViewでURLを開く実装）")
                        .font(.system(size: geometry.size.width * 0.04))
                        .padding(geometry.size.height * 0.02)
                }
                Button("閉じる", action: onClose)
                    .font(.system(size: geometry.size.width * 0.045))
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * 0.06)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(geometry.size.width * 0.02)
                    .padding(geometry.size.height * 0.02)
            }
        }
    }
}

struct PrivacySheetView: View {
    var onClose: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("プライバシーポリシー")
                    .font(.system(size: geometry.size.width * 0.06))
                    .bold()
                    .padding(geometry.size.height * 0.02)
                ScrollView {
                    Text("ここにプライバシーポリシーの内容を記載。\n\n（またはWebViewでURLを開く実装）")
                        .font(.system(size: geometry.size.width * 0.04))
                        .padding(geometry.size.height * 0.02)
                }
                Button("閉じる", action: onClose)
                    .font(.system(size: geometry.size.width * 0.045))
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * 0.06)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(geometry.size.width * 0.02)
                    .padding(geometry.size.height * 0.02)
            }
        }
    }
}

extension View {
    func inputRowStyle(fixedGeometry: FixedGeometry) -> some View {
        self
            .font(.system(size: fixedGeometry.width * 0.04))
            .frame(height: fixedGeometry.height * 0.06)
            .padding(.horizontal, fixedGeometry.width * 0.04)
            .background(Color(.systemGray6))
            .cornerRadius(fixedGeometry.width * 0.025)
            .padding(.bottom, fixedGeometry.height * 0.01)
    }
}

#Preview {
    SignupScreen()
}
