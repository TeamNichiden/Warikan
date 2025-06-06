//
//  LoginScreen.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var route: NavigationRouter
    
    var body: some View {
        GeometryReader { geometry in
            let screenSize = UIScreen.main.bounds.size // 使用固定的屏幕尺寸
            let fixedGeometry = FixedGeometry(width: screenSize.width, height: screenSize.height)
            
            ScrollView {
                VStack(spacing: fixedGeometry.height * 0.03) { // 3% スクリンの高さを間隔として
                    Text("ログイン")
                        .font(.system(size: fixedGeometry.width * 0.08)) // 8% スクリンの幅を文字の大きさ
                        .fontWeight(.bold)
                        .padding(.top, fixedGeometry.height * 0.05) // 5% スクリンの高さを頂点との間隔に
                    
                    VStack(alignment: .leading, spacing: fixedGeometry.height * 0.02) {
                        Text("メールアドレス")
                            .font(.system(size: fixedGeometry.width * 0.04))
                        TextField("メールアドレス", text: $vm.email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textRowStyle(fixedGeometry: fixedGeometry)
                        
                        Text("パスワード")
                            .font(.system(size: fixedGeometry.width * 0.04))
                        SecureField("パスワード", text: $vm.password)
                            .textRowStyle(fixedGeometry: fixedGeometry)
                    }
                    
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.system(size: fixedGeometry.width * 0.035))
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Text("パスワードを忘れた方")
                                .underline()
                                .font(.system(size: fixedGeometry.width * 0.035))
                        }
                        Text("/")
                            .font(.system(size: fixedGeometry.width * 0.035))
                        Button {
                            
                        } label: {
                            Text("ログインでお困りの方")
                                .underline()
                                .font(.system(size: fixedGeometry.width * 0.035))
                        }
                    }
                    .foregroundColor(.gray)
                    .fixedSize()
                    
                    Button(action: {
                        Task {
                            let success = await auth.signUp(email: vm.email, password: vm.password)
                            if success {
                                route.popToRoot()
                            }
                        }
                    }) {
                        if vm.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(maxWidth: .infinity)
                                .frame(height: fixedGeometry.height * 0.06)
                        } else {
                            Text("ログイン")
                                .foregroundColor(.white)
                                .font(.system(size: fixedGeometry.width * 0.045))
                                .frame(maxWidth: .infinity)
                                .frame(height: fixedGeometry.height * 0.06)
                                .background(Color.blue)
                                .cornerRadius(fixedGeometry.width * 0.02)
                        }
                    }
                    .disabled(vm.isLoading || vm.email.isEmpty || vm.password.isEmpty)
                    
                    Text("または")
                        .foregroundColor(.gray)
                        .font(.system(size: fixedGeometry.width * 0.035))
                    
                    Button(action: {
                        //Apple Login
                    }) {
                        HStack(spacing: fixedGeometry.width * 0.02) {
                            Image(systemName: "apple.logo")
                                .font(.system(size: fixedGeometry.width * 0.04))
                            Text("Appleでログイン")
                                .font(.system(size: fixedGeometry.width * 0.04))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: fixedGeometry.height * 0.06)
                        .background(Color.black)
                        .cornerRadius(fixedGeometry.width * 0.02)
                    }
                    
                    Button(action: {
                        // Google Login
                    }) {
                        HStack {
                            Image(.googleOld)
                                .resizable()
                                .scaledToFit()
                                .frame(width: fixedGeometry.width * 0.04)
                            Text("Googleでログイン")
                        }
                        .foregroundColor(.black)
                        .font(.system(size: fixedGeometry.width * 0.04))
                        .frame(maxWidth: .infinity)
                        .frame(height: fixedGeometry.height * 0.06)
                        .background(Color.white)
                        .cornerRadius(fixedGeometry.width * 0.02)
                        .overlay(
                            RoundedRectangle(cornerRadius: fixedGeometry.width * 0.02)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                    }
                    
                    Button(action: {
                        route.navigate(to: .signUp)
                    }) {
                        Text("会員登録はこちら")
                            .foregroundColor(.gray)
                            .font(.system(size: fixedGeometry.width * 0.04))
                            .underline()
                    }
                    
                    // MARK: TEST
                    Button(action: {
                        vm.login { succese in
                            auth.isLoggedIn = true
                            route.popToRoot()
                        }
                    }) {
                        Text("マネジャーモード")
                            .font(.system(size: fixedGeometry.width * 0.04))
                    }
                }
                .padding(.horizontal, fixedGeometry.width * 0.06) // 6% スクリンの幅を横の間隔として
                .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

// 固定几何尺寸结构体
struct FixedGeometry {
    let width: CGFloat
    let height: CGFloat
    
    var size: CGSize {
        CGSize(width: width, height: height)
    }
}

extension View {
    func textRowStyle(fixedGeometry: FixedGeometry) -> some View {
        self
            .font(.system(size: fixedGeometry.width * 0.04))
            .frame(height: fixedGeometry.height * 0.06)
            .padding(.horizontal, fixedGeometry.width * 0.04)
            .background(Color(.systemGray6))
            .cornerRadius(fixedGeometry.width * 0.02)
    }
}

#Preview {
    LoginScreen()
}
