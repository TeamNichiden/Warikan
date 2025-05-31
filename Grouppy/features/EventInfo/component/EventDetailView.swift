//
//  EventDetailView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

extension View {
    func EventDetailView(date: String, place: String, memo: String, editing: @escaping (() -> Void)) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // 日时信息
            EventDetailRow(
                icon: "calendar",
                iconColor: .blue,
                title: "日時",
                content: date
            )
            
            // 场所信息
            EventDetailRow(
                icon: "mappin.and.ellipse",
                iconColor: .red,
                title: "場所",
                content: place
            )
            
            // 备忘录信息
            EventDetailRow(
                icon: "note.text",
                iconColor: .orange,
                title: "メモ",
                content: memo,
                isExpandable: true
            )
        }
        .overlay(alignment: .topTrailing) {
            Button(action: editing) {
                Text("編集")
                    .underline()
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

// 新增的子组件
struct EventDetailRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let content: String
    var isExpandable: Bool = false
    @State private var isExpanded = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                // memoのみfoldingボタンを表示
                if isExpandable {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isExpanded.toggle()
                        }
                    } label: {
                        Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                            .foregroundColor(.secondary)
                            .font(.system(size: 14, weight: .medium))
                    }
                }
            }
            
            HStack {
                Rectangle()
                    .fill(iconColor.opacity(0.3))
                    .frame(width: 3)
                
                Text(content)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .lineLimit(isExpandable ? (isExpanded ? 1 : 2) : nil)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
    }
}

#Preview {
    VStack {
        Text("Sample")
            .EventDetailView(
                date: "2024年1月15日 18:00",
                place: "新宿居酒屋 鳥貴族",
                memo: "新年会です。飲み放題プランで予約済み。参加費は一人3000円程度を予定しています。",
                editing: {}
            )
    }
    .padding()
}
