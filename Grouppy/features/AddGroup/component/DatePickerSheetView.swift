//
//  test.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

// TODO: このコンポーネントはイベント追加画面で利用

struct DatePickerSheetView: View {
    @ObservedObject var vm: AddNewGroupViewModel
    
    var body: some View {
        VStack {
//            DatePicker(
//                "日付を選択",
//                selection:  $vm.selectedDate,
//                displayedComponents: [.date, .hourAndMinute]
//            )
//            .datePickerStyle(.graphical)
//            .padding(.vertical)
            
            Button {
//                vm.updateDate()
            } label: {
                Text("日付確定")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    DatePickerSheetView(vm: AddNewGroupViewModel())
}
