//
//  AddNewGroupView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import SwiftUI

struct AddNewGroupView: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject var vm = AddNewGroupViewModel()
  @EnvironmentObject var route: NavigationRouter

  var body: some View {
    ScrollView {
      VStack {
        Text("グループ作成")
          .font(.title)
          .fontWeight(.bold)
        Spacer()
        GroupInfoRow(title: "グループ名", message: "グループ名を入力(必須)", inputMessage: $vm.group.name)
        GroupInfoRow(title: "メモ", message: "詳細情報を入力(任意)", inputMessage: $vm.group.description)
        

        // MARK: メンバーリスト
        VStack(alignment: .leading) {
          Text("メンバー")
            .fontWeight(.bold)
          HStack {
            Button {

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
          if let newGroupId = vm.lastGroupId {
            route.navigate(to: .group(id: newGroupId))
          }
        } label: {
          Text("グループを作成")
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(vm.group.name.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(8)
        }
        .disabled(vm.group.name.isEmpty)
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
  AddNewGroupView()
}
