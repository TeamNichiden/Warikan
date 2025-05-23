//
//  AddNewEventView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import SwiftUI

struct AddNewEventView: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject var vm = AddNewEventViewModel()
  @EnvironmentObject var route: NavigationRouter

  var body: some View {
    ScrollView {
      VStack {
        Text("イベント作成")
          .font(.title)
          .fontWeight(.bold)
        Spacer()
        GroupInfoRow(title: "イベント名", message: "イベント名を入力(必須)", inputMessage: $vm.event.title)
        GroupInfoRow(title: "メモ", message: "詳細情報を入力(任意)", inputMessage: $vm.event.description)

        // メンバーリスト
        VStack(alignment: .leading) {
          Text("メンバー")
            .fontWeight(.bold)
          HStack {
            Button {
              // メンバー追加処理
            } label: {
              Image(systemName: "plus.circle.fill")
                .font(.system(size: 24))
            }
            Text("メンバーを追加")
          }
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color(.systemGray6))
          .cornerRadius(8)
        }
        .frame(maxWidth: .infinity)

        Spacer()
        Button {
          vm.isCheckingInfo()
          if let newEventId = vm.lastEventId {
            route.navigate(to: .event(id: newEventId))
          }
        } label: {
          Text("イベントを作成")
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(vm.event.title.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(8)
        }
        .disabled(vm.event.title.isEmpty)
        .padding(.vertical)
      }
      .onTapGesture {
        hideKeyboard()
      }
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  AddNewEventView()
}
