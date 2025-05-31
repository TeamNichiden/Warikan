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
        VStack(spacing: 24) {
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            VStack(alignment: .leading) {
                Text("メールアドレス")
                TextField("メールアドレス", text: $vm.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textRowStyle()
                
                Text("パスワード")
                SecureField("パスワード", text: $vm.password)
                    .textRowStyle()
            }
            
            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            HStack {
                Button {
                    
                } label: {
                    Text("パスワードを忘れた方")
                        .underline()
                }
                Text("/")
                Button {
                    
                } label: {
                    Text("ログインでお困りの方")
                        .underline()
                }
            }
            .foregroundColor(.gray)
            
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
                        .padding()
                } else {
                    Text("ログイン")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .disabled(vm.isLoading || vm.email.isEmpty || vm.password.isEmpty)
            
            Text("または")
                .foregroundColor(.gray)
            
            Button(action: {
                //Apple Login
            }) {
                HStack {
                    Image(systemName: "apple.logo")
                    Text("Appleでログイン")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(8)
            }
            
            Button(action: {
                // Google Login
            }) {
                // TODO: GOOGLE　LOGOを追加予定
                Text("Googleでログイン")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
            Button(action: {
                route.navigate(to: .signUp)
            }) {
                Text("会員登録はこちら")
                    .foregroundColor(.gray)
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
            }
        }
        .padding(.horizontal, 24)
    }
}


extension View {
    func textRowStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
}
    

#Preview {
    LoginScreen()
}
