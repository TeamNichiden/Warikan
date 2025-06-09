//
//  AddUserToEventSheet.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/08.
//

import SwiftUI

struct AddUserToEventSheet: View {
    @State var vm = FriendListViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("メンバーを追加")
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
                Button {
                    
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
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                Divider()
                
                Button(action: {
                    vm.shouldAddUsers.toggle()
                    if vm.shouldAddUsers {
                        vm.createEvent()
                    }
                }) {
                    if !vm.shouldAddUsers {
                        Text("イベント作成")
                            .font(.body)
                            .padding(4)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    } else {
                        Text("完了")
                            .font(.body)
                            .padding(4)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                }
                
                ForEach(MockData.users) { user in
                    AddUserSheetRow(
                        user: user,
                        isSelected: vm.selectedUsers.contains(user.id),
                        checkBox: vm.shouldAddUsers
                    ) {
                        if vm.selectedUsers.contains(user.id) {
                            vm.selectedUsers.remove(user.id)
                        } else {
                            vm.selectedUsers.insert(user.id)
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
