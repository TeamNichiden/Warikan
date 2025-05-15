//
//  GroupView+Extens.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//
import SwiftUI

extension View {
    func groupComponentStyle() -> some View {
        self
            .padding()
            .frame(alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
            .padding()
    }
}

extension GroupView {
    func miniHistoryRowStyle(message: String, price: String) -> some View {
        HStack {
            Circle()
                .fill(.green)
            Spacer()
            Text(message)
            Spacer()
            Text(price)
        }
        .fixedSize()
    }
}

extension View {
    func eventInfoStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
}
