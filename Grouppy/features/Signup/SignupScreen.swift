//
//  SignupScreen.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import SwiftUI

struct SignupScreen: View {
    @State private var isAgreed = false
    @State private var inputPassword = ""
    @State private var inputPasswordConfirm = ""
    @State private var isAlertPresented = false

    var body: some View {
        VStack {
            Text("アカウント作成")
                .font(.largeTitle)
            TextField("ユーザー名", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            
            TextField("メールアドレス", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            
            SecureField("パスワード", text: $inputPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            
            SecureField("パスワード確認", text: $inputPasswordConfirm)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            
            
            HStack {
                Image(systemName: isAgreed ? "checkmark.square" : "square")
                    .foregroundColor(.gray)
                
                Button(action: {
                    // TODO: Open terms of service
                }) {
                    Text("利用規約")
                        .foregroundColor(.blue)
                }
                Text("に同意する")
                    .foregroundColor(.gray)
            }.onTapGesture {
                isAgreed.toggle()
            }
            
            Button(action: {
                if validatePassword() {
                    // TODO: Implement signup action
                } else {
                    isAlertPresented = true
                    inputPasswordConfirm = ""
                }
            }) {
                Text("アカウント作成")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        }.padding(.horizontal, 20)
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("エラー"), message: Text("パスワードが一致しません"), dismissButton: .default(Text("OK")))
            }
    }

    private func validatePassword() -> Bool {
        return inputPassword == inputPasswordConfirm
    }
}

#Preview {
    SignupScreen()
}
