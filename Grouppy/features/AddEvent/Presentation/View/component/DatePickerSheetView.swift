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
            // Date Picker Card - 修正宽度变形问题
            VStack(spacing: 12) {
                // MARK: - 日付選択
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
                .frame(height: 180) // 限制DatePicker高度
                .clipped() // 防止内容溢出
                
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.15), radius: 6, x: 0, y: 2)
            )
            
            // MARK: - Selected Date Display
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                        .font(.title3)
                    Text("選択された日時")
                        .font(.headline)
                        .fontWeight(.medium)
                    Spacer()
                }
                
                    VStack(alignment: .leading, spacing: 4) {
                        Text(formatDate(vm.selectedDate))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(1) // 防止文本换行
                        HStack {
                            Text(formatTime(vm.selectedDate))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            // Status Badge - 修正宽度约束
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
                                .fixedSize() // 防止标签变形
                            } else {
                                HStack(spacing: 4) {
                                    Circle()
                                        .fill(Color.orange)
                                        .frame(width: 6, height: 6)
                                    Text("過去")
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
                                .fixedSize() // 防止标签变形
                            }
                        }
                    }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.15), radius: 6, x: 0, y: 2)
            )
            
            
            
            // MARK: - Confirm Button
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
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [Color.blue, Color.blue.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .blue.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .buttonStyle(ScaleButtonStyle())
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
