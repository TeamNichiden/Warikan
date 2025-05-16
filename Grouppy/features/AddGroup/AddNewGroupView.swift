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
        GroupInfoRow(title: "グループ名", message: "グループ名を入力(必須)", inputMessage: $vm.mockGroup.groupName)
        GroupInfoRow(title: "メモ", message: "詳細情報を入力(任意)", inputMessage: $vm.mockGroup.groupMemo)
        GroupInfoRow(
          title: "日時", message: "", inputMessage: $vm.mockGroup.dateStr, isInputText: true,
          btnIcon: "calendar", action: vm.showCalendar)
        GroupInfoRow(
          title: "場所", message: "場所を選択または入力(任意)", inputMessage: $vm.mockGroup.palce,
          btnIcon: "location", action: vm.showMap)

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
            .background(vm.mockGroup.groupName.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(8)
        }
        .disabled(vm.mockGroup.groupName.isEmpty)
        .padding(.vertical)
      }
      .onTapGesture {
        hideKeyboard()
      }
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear {
      vm.initialDate()
    }
    .sheet(isPresented: $vm.showDatePicker) {
      DatePickerSheetView(vm: vm)
    }
  }
}

#Preview {
  AddNewGroupView()
}
