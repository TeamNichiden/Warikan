//
//  GroupListView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

class MockGroupList {
    static let shared = MockGroupList()
    
    private init() {}
    
    var groupList: [MockGroupModel] = []
}

class GroupListViewModel: ObservableObject {
    @Published var searchMessage: String = ""
    @Published var groupList = MockGroupList.shared.groupList
    @Published var selectedGroupId: UUID? = nil
    @Published var isShowingGroupView = false
    
    func showSelectedGroup(_ group: MockGroupModel) {
        selectedGroupId = group.id
        isShowingGroupView = true
    }
}

struct GroupListView: View {
    @StateObject var vm = GroupListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // TODO: グループ作成画面に遷移
                }) {
                    addButton()
                }
            }
            .padding(.bottom)
            
            // TODO: SearchBar作成
            
            TextField("検索", text: $vm.searchMessage)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    if !vm.groupList.isEmpty {
                        ForEach(vm.groupList) { group in
                            Button(action: {
                                vm.showSelectedGroup(group)
                            }) {
                                HStack {
                                    // TODO: グループアイコンを設定
                                    
                                    // グループ名表示
                                    Text(group.groupName)
                                }
                                .padding()
                                .frame(width: UIScreen.main.bounds.width, height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 1).opacity(0.1)
                                )
                                .padding(.horizontal)
                            }
                        }
                    } else {
                        Text("現在はグループがありません")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $vm.isShowingGroupView) {
            if let groupId = vm.selectedGroupId {
                GroupView(groupId: groupId)
            } else {
                Text("グループが選択されていません")
            }
        }
        .onAppear() {
            print(vm.groupList.count)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    GroupListView()
}
