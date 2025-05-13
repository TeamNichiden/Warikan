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
}

struct GroupView: View {
    @StateObject var vm = GroupViewModel()
    
    var body: some View {
        VStack {
            // MARK: メンバーリスト
            VStack {
                Text("メンバー")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    
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
            // TODO: creategroupブランチをマージしたら引数を置き換える。
            EventInfoView(date: "2025年5月13日 14:00", place: "代々木公園", memo: "現金を持参してください")
                .frame(maxWidth: .infinity, alignment: .leading)
                .eventInfoStyle()
            
            // MARK: 支払い状況テーブル
            VStack {
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
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                
                miniHistoryRowStyle(message: "山田さんが支払いしました", price: "¥1000")
                miniHistoryRowStyle(message: "山田さんが支払いしました", price: "¥1000")
                miniHistoryRowStyle(message: "山田さんが支払いしました", price: "¥1000")
            }
            //        .frame(height: 400) // TODO: 初期値再設定検討
            .groupComponentStyle()
            // MARK: 支払いボタン
            
            Button {
                
            } label: {
                Text("支払い記録を追加")
                    .viewButtonStyle()
            }
            
            Button {
                
            } label: {
                Text("支払い完了") // 押されたら、履歴に「支払い完了」messageが追加される。
                    .viewButtonStyle()
            }
            
        }
        .padding()
    }
}

extension View {
    func groupComponentStyle() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
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
        .payInfoRowStyle()
    }
}

extension View {
    func payInfoRowStyle() -> some View {
        self
            .padding()
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(8)
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
    GroupView()
}
