//
//  GroupView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

struct GroupView: View {
  @StateObject var vm: GroupViewModel
  @EnvironmentObject var route: NavigationRouter
  init(groupId: String) {
    _vm = StateObject(wrappedValue: GroupViewModel(groupId: groupId))
  }

  var body: some View {
    // MARK: イベントタイトル
    Text(vm.group.name)
      .font(.title)
      .fontWeight(.bold)
    ScrollView {
      memberListSection
      eventInfoSection
      paymentStatusSection
      actionButtonsSection
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Subviews
  private var memberListSection: some View {
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
  }

  private var eventInfoSection: some View {
    // 先頭イベントを仮で表示（なければ空文字）
    let event = vm.group.events?.first
      return EventInfoView(
      date: event?.date.formatted() ?? "",
      place: event?.place ?? "",
      memo: event?.description ?? ""
    )
    .frame(maxWidth: .infinity, alignment: .leading)
    .eventInfoStyle()
    .padding(.horizontal)
  }

  private var paymentStatusSection: some View {
    // 先頭イベントの合計金額を仮で表示
    let event = vm.group.events?.first
    let total = event?.transactions?.reduce(0) { $0 + $1.amount } ?? 0
      return VStack {
      Text("支払い状況")
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
      Text("¥ \(total)")
        .font(.title)
      Text("合計金額")
        .foregroundColor(.gray)
      Rectangle()
        .frame(height: 1)
        .foregroundStyle(Color(.systemGray4))
        .padding(.vertical)
      // TODO: 支払い履歴をevent.transactionsから生成
      if let transactions = event?.transactions {
        ForEach(transactions) { txn in
          MiniHistoryRow(message: "\(txn.payerId)が支払いしました", price: "¥\(txn.amount)")
        }
      } else {
        Text("支払い履歴なし")
          .foregroundColor(.gray)
      }
    }
    .groupComponentStyle()
  }

  private var actionButtonsSection: some View {
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
        route.popToRoot()
      } label: {
        Text("戻る")
          .viewButtonStyle()
      }
    }
    .padding(.top, 40)
  }
}

#Preview {
    GroupView(groupId: MockData.groups[0].id)
}
