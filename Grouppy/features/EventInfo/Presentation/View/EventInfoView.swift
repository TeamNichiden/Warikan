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
        // イベントタイトル
        Text(event.title)
          .font(.title)
          .fontWeight(.bold)
        ScrollView {
          memberListSection(event: event)
          eventInfoSection(event: event)
          paymentStatusSection(event: event)
          actionButtonsSection
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        ProgressView()
      }
    }
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
  }

  private func eventInfoSection(event: Event) -> some View {
    EventDetailView(
      date: event.date,
      place: event.place,
      memo: event.description
    )
    .frame(maxWidth: .infinity, alignment: .leading)
    .eventInfoStyle()
    .padding(.horizontal)
  }

  private func paymentStatusSection(event: Event) -> some View {
    let total = event.transactions.reduce(0) { $0 + $1.amount }
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
      if !event.transactions.isEmpty {
        ForEach(event.transactions) { txn in
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
  EventInfoView(eventId: "sampleEventId")
}
