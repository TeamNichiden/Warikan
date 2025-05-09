//
//  EditableUserInfoView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//


import SwiftUI



struct UserInfo: View {
    //MARK: TEST
    @State private var password:String = "******"
    
    @ObservedObject var vm: EditableProfileViewModel
    
    var body: some View {
        VStack {
            infoRowView(title: "ニックネーム", inputText: $vm.editUser.name)
            infoRowView(title: "アカウントID", inputText: $vm.editUser.userID)
            infoRowView(title: "メールアドレス", inputText: $vm.editUser.email,isEditable: false, submitLabel: "再設定",submitAction: vm.resetEmail)
            infoRowView(title: "パスワード", inputText: $password,isEditable: false, submitLabel: "再設定",submitAction: vm.resetPassword)
        }
        .padding(.horizontal,20)
        .padding(.vertical,25)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(lineWidth: 1).opacity(0.1)
        )
    }
}

extension UserInfo {
    func infoRowView(
        title:String,
        inputText:Binding<String>,
        isEditable:Bool = true,
        submitLabel:String? = nil,
        submitAction:(() -> Void)? = nil
    ) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            HStack {
                TextField("",text: inputText)
                    .foregroundColor(isEditable ? .black : .gray)
                    .disabled(!isEditable)
                if !isEditable {
                    if let submitLabel = submitLabel, let submitAction = submitAction {
                        Button {
                            submitAction()
                        } label: {
                            Text(submitLabel)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

#Preview {
    UserInfo(vm: EditableProfileViewModel())
}
