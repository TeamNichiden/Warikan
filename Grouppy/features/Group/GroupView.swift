//
//  GroupView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

struct GroupView: View {
    @StateObject var vm: GroupViewModel
    
    init(groupId: UUID) {
        _vm = StateObject(wrappedValue: GroupViewModel(groupId: groupId))
    }
    
    var body: some View {
        // MARK: イベントタイトル
        Text(vm.group.groupName)
            .font(.title)
            .fontWeight(.bold)
        ScrollView {
            // MARK: メンバーリスト
            VStack {
                Text("メンバー")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    // TODO: メンバー追加アクション
                } label: {
                    addButton()
                }
            }
            .groupComponentStyle()
            
            // MARK: イベント情報
            // TODO: Mockデータを置き換える
            EventInfoView(date: vm.group.dateStr, place: vm.group.palce, memo: vm.group.groupMemo)
                .frame(maxWidth: .infinity, alignment: .leading)
                .eventInfoStyle()
                .padding(.horizontal)
            
            VStack {
                // MARK: 支払い状況テーブル
                Text("支払い状況")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("¥ \(vm.mockTable.totalPriceStr)")
                    .font(.title)
                Text("合計金額")
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color(.systemGray4))
                    .padding(.vertical)
                // TODO: Mockデータを置き換える
                miniHistoryRowStyle(message: "山田さんが支払いしました", price: "¥1000")
                miniHistoryRowStyle(message: "山田さんが支払いしました", price: "¥1000")
                miniHistoryRowStyle(message: "山田さんが支払いしました", price: "¥1000")
            }
            .groupComponentStyle()
            // MARK: 支払いボタン
            VStack(spacing: 8) {
                
                Button {
                    // 支払い記録を追加
                } label: {
                    Text("支払い記録を追加")
                        .viewButtonStyle()
                }
                
                Button {
                    // 支払い完了
                } label: {
                    Text("支払い完了")
                        .viewButtonStyle()
                }
                
                Button {
                    vm.backToHomeView = true
                } label: {
                    Text("戻る")
                        .viewButtonStyle()
                }
            }
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $vm.backToHomeView) {
            HomeView()
        }
        .onAppear() {
            print("GroupViewId: \(vm.group.id)")
        }
        
    }
}

#Preview {
    GroupView(groupId: MockGroupModel.ID())
}
