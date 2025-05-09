//
//  EditableProfileView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var vm = UserProfileViewModel()
    
    var body: some View {
        
        VStack {
            Text("アカウント編集")
                .fontWeight(.bold)
            Circle() /*アイコン*/
                .fill(Color(.systemGray6))
                .frame(width: 100)
                .padding()
            Button(action: { /*カメラ/ライブラリ選択できるPicker起動*/ }) {
                Text("アイコンを変更")
                    .font(.system(size: 14))
            }
            
            Spacer()
            
            UserInfo(vm: vm)
            
            Spacer()
            
            Button(action: { /*変えた情報をfirestoreに反映*/ }) {
                Text("変更を保存")
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        Spacer()
    }
}

#Preview {
    UserProfileView()
}
