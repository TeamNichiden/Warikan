//
//  AddUserToEventSheet.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/08.
//

import SwiftUI

struct AddUserToEventSheet: View {
    @State var vm = FriendListViewModel()
    @Environment(\.dismiss) private var dismiss
    init(vm: FriendListViewModel = FriendListViewModel()) {
        self.vm = vm
        self.vm.shouldAddUsers = true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("メンバーを追加")
                    .fontWeight(.bold)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
            .overlay(alignment: .trailing) {
                Button {
                    dismiss()
                } label: {
                    Text("完了")
                }
            }
            Text("\(vm.numOfUsers)人選択中")
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
            ScrollView {
                Divider()
                // ユーザー検索欄
                TextField("検索", text: $vm.inputText)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                Divider()
                    .padding(.bottom)
                
                ForEach(MockData.users) { user in
                    AddUserSheetRow(
                        user: user,
                        isSelected: vm.selectedUsers.contains(user.id),
                        checkBox: vm.shouldAddUsers
                    ) {
                        if vm.selectedUsers.contains(user.id) {
                            vm.selectedUsers.remove(user.id)
                            vm.showCurrentUsers()
                        } else {
                            vm.selectedUsers.insert(user.id)
                            vm.showCurrentUsers()
                        }
                    }
                    Divider()
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddUserToEventSheet()
}
