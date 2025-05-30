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
      TextField("メールアドレス", text: $vm.email)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
      SecureField("パスワード", text: $vm.password)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
      if let error = vm.errorMessage {
        Text(error)
          .foregroundColor(.red)
          .font(.caption)
      }
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
      Spacer()
    }
    .padding(.horizontal, 24)
  }
}

#Preview {
  LoginScreen()
}
