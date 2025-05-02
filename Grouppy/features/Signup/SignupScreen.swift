//
//  SignupScreen.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import SwiftUI

struct SignupScreen: View {
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
            
            SecureField("パスワード", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            
            SecureField("パスワード確認", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            
            
            HStack {
                Image(systemName: "checkmark.square")
                    .foregroundColor(.blue)
                Text("利用規約に同意する")
                    .foregroundColor(.blue)
            }
            
            Button(action: {
                // TOOD: Implement signup action
            }) {
                Text("アカウント作成")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            
            
        }.padding(.horizontal, 20)
    }
}

#Preview {
    SignupScreen()
}
