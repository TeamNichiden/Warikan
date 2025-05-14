//
//  GroupView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

struct MockTableModel {
    let id = UUID()
    var totalPrice: Int = 0
    var totalPriceStr: String = "0"
}

class GroupViewModel: ObservableObject {
    @Published var mockTable = MockTableModel()
    @Published var group: MockGroupModel
    @Published var backToHomeView: Bool = false
    
    init(groupId: UUID) {
        if let found = MockGroupList.shared.groupList.first(where: { $0.id == groupId }) {
            self.group = found
        } else {
            self.group = MockGroupModel()
        }
    }
}

struct GroupView: View {
    let groupId: UUID
    @StateObject var vm: GroupViewModel
    
    init(groupId: UUID) {
        self.groupId = groupId
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
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 32)
                        Image(systemName: "plus")
                    }
                }
            }
            .groupComponentStyle()
            
            // MARK: イベント情報
            // TODO: Mockデータを置き換える
            EventInfoView(date: "2025年5月13日 14:00", place: "代々木公園", memo: "現金を持参してください")
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
            
            Button {
                
            } label: {
                Text("支払い記録を追加")
                    .viewButtonStyle()
            }
            
            Button {
                // MARK: TEST
                vm.backToHomeView = true
            } label: {
                Text("支払い完了")
                // 押されたら、履歴に「支払い完了」messageが追加される。
                    .viewButtonStyle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $vm.backToHomeView) {
            HomeView()
        }
    }
}

extension View {
    func groupComponentStyle() -> some View {
        self
            .padding()
            .frame(alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
            .padding()
    }
}

extension GroupView {
    func miniHistoryRowStyle(message: String, price: String) -> some View {
        HStack {
            Circle()
                .fill(.green)
            Spacer()
            Text(message)
            Spacer()
            Text(price)
        }
        .fixedSize()
    }
}

extension View {
    func eventInfoStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
}

#Preview {
    let sampleGroup = MockGroupModel(groupName: "イベント")
    MockGroupList.shared.groupList.append(sampleGroup)
    return GroupView(groupId: sampleGroup.id)
}
