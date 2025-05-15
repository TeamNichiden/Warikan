//
//  GroupListView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

struct GroupListView: View {
    @StateObject var vm = GroupListViewModel()
    @EnvironmentObject var route: NavigationRouter
    
    var body: some View {
//        NavigationStack(path: $route.path) {
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
                                    route.navigate(to: .group(id: group.id))
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
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .group(let id):
                    GroupView(groupId: id)
                default:
                    EmptyView()
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
//        }
    }
}

#Preview {
    GroupListView()
}
