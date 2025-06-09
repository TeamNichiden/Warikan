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
            VStack(spacing: 0) {
                // Header Section
                VStack(spacing: 16) {
                    // Drag Indicator
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 36, height: 5)
                        .padding(.top, 8)
                    
                    // Title
                    Text("日付と時間を選択")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .background(Color(.systemBackground))
                
                // Content Section
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
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                    )
                    
                    // Selected Date Display
                    VStack(spacing: 12) {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.green)
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
                                
                                Text(formatTime(vm.selectedDate))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            
                            // Status Badge
                            if vm.selectedDate >= Calendar.current.startOfDay(for: Date()) {
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 8, height: 8)
                                    Text("確認済み")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.green)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.green.opacity(0.1))
                                )
                            } else {
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 8, height: 8)
                                    Text("異常な日時")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.red.opacity(0.1))
                                )
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                    )
                    
                    Spacer()
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        // Confirm Button
                        Button(action: {
                            dismiss()
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
                        
                        // Cancel Button
                        Button(action: {
                            dismiss()
                        }) {
                            Text("キャンセル")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .background(Color(.systemGroupedBackground))
            }
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
