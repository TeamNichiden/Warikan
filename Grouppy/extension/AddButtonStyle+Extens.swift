//
//  AddButtonStyle+Extens.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

extension View {
    func addButton() -> some View {
        ZStack {
            Circle()
                .fill(Color(.systemGray6))
                .frame(width: 32)
            Image(systemName: "plus")
        }
    }
}
