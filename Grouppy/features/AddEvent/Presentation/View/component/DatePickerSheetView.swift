//
//  DatePickerSheetView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

// TODO: このコンポーネントはイベント追加画面で利用

struct DatePickerSheetView: View {
    @ObservedObject var vm: AddNewEventViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Date Picker Card
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                            .font(.title3)
                        Text("イベント日時")
                            .font(.headline)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    
                    DatePicker(
                        "日付を選択",
                        selection: $vm.selectedDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)  // 改为纯白色背景
                        .shadow(color: .gray.opacity(0.15), radius: 10, x: 0, y: 3)
                )
                
                // Selected Date Display
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.blue)  // 改为蓝色保持一致性
                            .font(.title3)
                        Text("選択された日時")
                            .font(.headline)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(formatDate(vm.selectedDate))
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            HStack {
                                Text(formatTime(vm.selectedDate))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                // Status Badge
                                if vm.selectedDate >= Calendar.current.startOfDay(for: Date()) {
                                    HStack(spacing: 4) {
                                        Circle()
                                            .fill(Color.green)
                                            .frame(width: 6, height: 6)
                                        Text("確認済み")
                                            .font(.caption2)
                                            .fontWeight(.medium)
                                            .foregroundColor(.green)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule()
                                            .fill(Color.green.opacity(0.1))
                                    )
                                } else {
                                    HStack(spacing: 4) {
                                        Circle()
                                            .fill(Color.orange)
                                            .frame(width: 6, height: 6)
                                        Text("過去の日付")
                                            .font(.caption2)
                                            .fontWeight(.medium)
                                            .foregroundColor(.orange)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule()
                                            .fill(Color.orange.opacity(0.1))
                                    )
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)  // 改为纯白色背景
                        .shadow(color: .gray.opacity(0.15), radius: 10, x: 0, y: 3)
                )
                
                Spacer()
                
                // Confirm Button
                Button(action: {
                    vm.updateDate()
                    withAnimation(.spring()) {
                        vm.showDatePicker = false
                    }
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                        Text("日時を確定")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            colors: [Color.blue, Color.blue.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(ScaleButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(
                LinearGradient(
                    colors: [Color(.systemGray6), Color(.systemGray5)],  // 改为浅灰色渐变背景
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Helper Functions
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "M月d日(E)"
        return formatter.string(from: date)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    DatePickerSheetView(vm: AddNewEventViewModel())
}
