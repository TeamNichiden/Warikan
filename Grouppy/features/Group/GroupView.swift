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
    let event = vm.group.events?.first
    let transactions = event?.transactions ?? []
    // Card型配列に変換（Transactionのpayer, payeesのnameを利用）
    @State var cards: [Card] = transactions.map { txn in
      Card(
        payerId: txn.payer?.name ?? "不明",
        amount: txn.amount,
        description: txn.memo,
        members: txn.payees?.map { $0.name } ?? [],
        paidMembers: txn.payeesPaid.map { $0 }
      )
    }
    return VStack {
      CardStackView(cards: $cards)
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
    }
    .padding(.top, 40)
  }
}

#Preview {
  GroupView(groupId: MockData.groups[0].id)
}
