//
//  HomeView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI


struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                //MARK: HEADER
                HStack {
                    MiniProfile()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6).opacity(0.6))
                .cornerRadius(10)
                .overlay(alignment: .topTrailing) {
                    Button {
                        vm.isEdit = true
                    } label: {
                        Text("編集")
                            .underline()
                            .padding()
                    }
                }
                
                Spacer()
                
                //MARK: FOOTER
                VStack(alignment: .leading) {
                    Text("グループ管理")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    groupCard(action: { /*グルー作成画面へ遷移*/ },
                              btnImg: "plus.circle.fill",
                              title: "グリープ作成",
                              message: "新しいグループを作成する")
                    
                    groupCard(action: { /*グループリストを表示*/ },
                              btnImg: "list.dash",
                              title: "グループ確認",
                              message: "所属グループを確認する")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationDestination(isPresented: $vm.isEdit) {
                UserProfileView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
