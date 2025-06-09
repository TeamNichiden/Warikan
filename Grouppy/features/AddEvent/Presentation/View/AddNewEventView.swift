//
//  AddNewEventView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import SwiftUI
import UIKit

struct AddNewEventView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = AddNewEventViewModel()
    @EnvironmentObject var route: NavigationRouter
    @State private var isShowFriendList: Bool = false
    @State private var showingSuccessAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: - Fixed Navigation Bar
                fixedNavigationBar
                
                // MARK: - Scrollable Content
                ScrollView {
                    VStack(spacing: 24) {
                        // MARK: - Progress Section
                        progressSection
                        
                        // MARK: - Event Details Section
                        eventDetailsSection
                        
                        // MARK: - Date & Location Section
                        dateLocationSection
                        
                        // MARK: - Members Section
                        membersSection
                        
                        // MARK: - Create Button
                        createEventButton
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isShowFriendList) {
                AddUserToEventSheet()
                    .presentationDetents([.fraction(0.8)])
            }
            .alert("イベント作成完了", isPresented: $showingSuccessAlert) {
                Button("確認") {
                    if let newEventId = vm.lastEventId {
                        route.navigate(to: .event(id: newEventId))
                    }
                }
            } message: {
                Text("イベントが正常に作成されました")
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationBarBackButtonHidden(false)
    }
    
    // MARK: - Fixed Navigation Bar
    private var fixedNavigationBar: some View {
        HStack {
            // Title
            Text("イベント作成")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
        )
    }
    
    // MARK: - Progress Section
    private var progressSection: some View {
        VStack(spacing: 12) {
            // Progress Indicator
            ProgressView(value: progressValue)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            // Progress Text
            HStack {
                Text("進捗状況")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int(progressValue * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
    
    private var progressValue: Double {
        var progress: Double = 0
        if !vm.event.title.isEmpty { progress += 0.4 }
        if !vm.event.date.isEmpty { progress += 0.3 }
        if !vm.event.place.isEmpty { progress += 0.3 }
        return progress
    }
    
    // MARK: - Event Details Section
    private var eventDetailsSection: some View {
        VStack(spacing: 16) {
            SectionHeader(icon: "doc.text", title: "イベント詳細")
            
            ModernEventInfoRow(
                title: "イベント名",
                placeholder: "イベント名を入力してください",
                text: $vm.event.title,
                isRequired: true
            )
            
            ModernEventInfoRow(
                title: "メモ",
                placeholder: "詳細情報を入力（任意）",
                text: $vm.event.description,
                isMultiline: true
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Date & Location Section
    private var dateLocationSection: some View {
        VStack(spacing: 16) {
            SectionHeader(icon: "calendar.badge.clock", title: "日時・場所")
            
            // 日时选择
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    vm.showDatePicker.toggle()
                }
            } label: {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                        .frame(width: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("日時")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                        
                        Text(vm.event.date.isEmpty ? "日時を選択してください" : vm.event.date)
                            .font(.body)
                            .foregroundColor(vm.event.date.isEmpty ? .secondary : .primary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(vm.showDatePicker ? 90 : 0))
                        .animation(.easeInOut(duration: 0.3), value: vm.showDatePicker)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.tertiarySystemGroupedBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(vm.event.date.isEmpty ? Color.clear : Color.blue.opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(ScaleButtonStyle())
            
            // 日期选择器
            if vm.showDatePicker {
                VStack(spacing: 12) {
                    DatePickerSheetView(vm: vm)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.quaternarySystemFill))
                )
            }
            
            // 地点选择
            Button {
                vm.moveToAppleMap()
            } label: {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                        .frame(width: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("場所")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                        
                        Text(vm.event.place.isEmpty ? "場所を選択してください" : vm.event.place)
                            .font(.body)
                            .foregroundColor(vm.event.place.isEmpty ? .secondary : .primary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.tertiarySystemGroupedBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(vm.event.place.isEmpty ? Color.clear : Color.red.opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Members Section
    private var membersSection: some View {
        VStack(spacing: 16) {
            SectionHeader(icon: "person.2", title: "メンバー")
            
            Button {
                isShowFriendList = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("メンバーを追加")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                        
                        Text("友達を招待してイベントを共有")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.tertiarySystemGroupedBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green.opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Create Button
    private var createEventButton: some View {
        Button {
            vm.isCheckingInfo()
            showingSuccessAlert = true
        } label: {
            HStack {
                if vm.event.title.isEmpty {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                }
                
                Text(vm.event.title.isEmpty ? "イベント名を入力してください" : "イベントを作成")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(vm.event.title.isEmpty ? Color.gray : Color.blue)
                    .shadow(color: vm.event.title.isEmpty ? .clear : .blue.opacity(0.3), radius: 8, x: 0, y: 4)
            )
        }
        .disabled(vm.event.title.isEmpty)
        .buttonStyle(ScaleButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: vm.event.title.isEmpty)
    }
}

// MARK: - Supporting Views
struct SectionHeader: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
}

struct ModernEventInfoRow: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var isMultiline: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                if isRequired {
                    Text("*")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Spacer()
            }
            
            if isMultiline {
                TextEditor(text: $text)
                    .frame(minHeight: 80)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.tertiarySystemGroupedBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(text.isEmpty ? Color.clear : Color.blue.opacity(0.3), lineWidth: 1)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(ModernTextFieldStyle(isFocused: !text.isEmpty))
            }
        }
    }
}

struct ModernTextFieldStyle: TextFieldStyle {
    let isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.tertiarySystemGroupedBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.blue.opacity(0.3) : Color.clear, lineWidth: 1)
            )
    }
}

#Preview {
    AddNewEventView()
}
