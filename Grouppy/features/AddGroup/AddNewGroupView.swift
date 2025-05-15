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
    
    var body: some View {
        ScrollView {
            VStack {
                Text("グループ作成")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                groupInfoRow(title: "グループ名", message: "グループ名を入力(必須)", inputMessage: $vm.mockGroup.groupName)
                groupInfoRow(title: "メモ", message: "詳細情報を入力(任意)", inputMessage: $vm.mockGroup.groupMemo)
                groupInfoRow(title: "日時", message: "", inputMessage: $vm.mockGroup.dateStr, isInputText: true, btnIcon: "calendar", action: vm.showCalendar)
                groupInfoRow(title: "場所", message: "場所を選択または入力(任意)", inputMessage: $vm.mockGroup.palce, btnIcon: "location", action: vm.showMap)
                
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
                    print("作成時のGroup: \(vm.mockGroup.id)")
                } label: {
                    Text("グループを作成")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(vm.isCreating ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!vm.isCreating)
                .padding(.vertical)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            vm.initialDate()
        }
        .sheet(isPresented: $vm.showDatePicker) {
            DatePickerSheetView(vm: vm)
        }
        .fullScreenCover(isPresented: $vm.isShowGroup) {
            if let groupId = vm.lastGroupId {
                GroupView(groupId: groupId)
            }
        }
    }
}

extension AddNewGroupView {
    func groupInfoRow(
        title: String,
        message: String,
        inputMessage: Binding<String>,
        isInputText: Bool = false,
        btnIcon: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            HStack {
                TextField(message,text: inputMessage)
                    .disabled(isInputText)
                    .onChange(of: vm.mockGroup.groupName) {
                        vm.isCreating = !vm.mockGroup.groupName.isEmpty
                    }
                if let btnIcon, let action {
                    Button(action: action) {
                        Image(systemName: btnIcon)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

#Preview {
    AddNewGroupView()
}
