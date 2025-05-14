//
//  ViewButtonStyle.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

extension View {
    func viewButtonStyle() -> some View {
        self
            .foregroundColor(Color.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(8)
    }
}
