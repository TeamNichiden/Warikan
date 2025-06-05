//
//  test.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

// TODO: このコンポーネントはイベント追加画面で利用

struct DatePickerSheetView: View {
    @ObservedObject var vm: AddNewEventViewModel
    
    var body: some View {
        VStack {
            DatePicker(
                "日付を選択",
                selection:  $vm.selectedDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    DatePickerSheetView(vm: AddNewEventViewModel())
}
