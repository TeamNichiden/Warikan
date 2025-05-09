//
//  EditableProfileView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct EditableProfileView: View {
    @StateObject var vm = EditableProfileViewModel()
    
    var body: some View {
        
        VStack {
            
            //MARK: タイトル
            Text("アカウント編集")
                .fontWeight(.bold)
            //MARK: アイコン
            Circle()
                .fill(Color.gray)
                .frame(width: 100)
            
            Button(action: {
                
            }) {
                Text("アイコンを変更")
                    .font(.system(size: 14))
            }
            Spacer()
            
            UserInfo(vm: vm)
            Spacer()
            //MARK: 保存ボタン
            Button(action: {
                
            }) {
                Text("変更を保存")
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        Spacer()
        
    }
}

#Preview {
    EditableProfileView()
}
