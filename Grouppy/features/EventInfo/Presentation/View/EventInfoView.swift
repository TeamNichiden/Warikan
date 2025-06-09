//
//  GroupView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

struct EventInfoView: View {
    let eventId: String
    @StateObject private var vm: EventInfoViewModel
    @EnvironmentObject var route: NavigationRouter
    
    init(eventId: String) {
        self.eventId = eventId
        _vm = StateObject(wrappedValue: EventInfoViewModel(eventId: eventId))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let event = vm.event {
                VStack(spacing: 16) {
                    // イベントタイトル
                    Text(event.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    // 添加 ScrollView 包装整个内容
                    ScrollView {
                        VStack(spacing: 8) {
                            memberListSection(event: event)
                            eventInfoSection(event: event)
                                .padding(.horizontal)
                            HStack {
                                Text("支払い状況")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                                Button(action: {/* transactionの追加ボタン */}) {
                                    Image(systemName: "plus")
                                }
                            }
                            .padding(.horizontal, 24)
                            paymentStatusSection(title: "居酒屋代", event: event)
                            actionButtonsSection
                        }
                    }
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Subviews
    private func memberListSection(event: Event) -> some View {
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
        .padding(.bottom)
    }
    
    private func eventInfoSection(event: Event) -> some View {
        EventDetailView(
            date: event.date,
            place: event.place,
            memo: event.description,
            editing: { /*編集シートかNavigationで画面遷移*/ }
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .eventInfoStyle()
    }
    
    private func paymentStatusSection(title: String, event: Event) -> some View {
        let total = event.transactions.reduce(0) { $0 + $1.amount }
        return VStack(spacing: 12) {
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            
            HStack(alignment: .bottom) {
                Text("合計金額")
                    .foregroundColor(.gray)
                Text("¥ \(total)")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Divider()
            
            if !event.transactions.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(event.transactions) { txn in
                            MiniHistoryRow(message: "\(txn.payerId)が支払いしました", price: "¥\(txn.amount)")
                        }
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, alignment: .top)
                }
                .frame(minHeight: 150, maxHeight: 200)
            } else {
                Text("支払い履歴なし")
                    .foregroundColor(.gray)
                    .frame(height: 60)
            }
            Divider()
            if (true) {
                /*
                 もしこのtransactionのオーナーではない場合表示
                 そして、支払い方法選択をシートで表示
                 */
                Button {
                    
                } label: {
                    Text("支払う")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(.purple)
                        .cornerRadius(8)
                }
                .padding(.vertical)
            }
        }
        .groupComponentStyle()
    }
    
    private var actionButtonsSection: some View {
        VStack(spacing: 8) {
            Button {
                route.popToRoot()
            } label: {
                Text("戻る")
                    .buttonStyle(ScaleButtonStyle())
            }
        }
        .padding(.top, 24)
        .padding(.horizontal)
    }
}

#Preview {
    EventInfoView(eventId: "sampleEventId")
}
