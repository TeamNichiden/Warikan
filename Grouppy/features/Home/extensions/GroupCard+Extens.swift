//
//  File.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/09.
//
import SwiftUI

extension View {
    func groupCard(action: @escaping () -> Void,btnImg:String, title: String, message: String) -> some View {
        HStack {
            Button(action: action) {
                Image(systemName: btnImg)
                    .font(.system(size: 40))
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .fontWeight(.bold)
                        .padding(.bottom,8)
                    Text(message)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }
            .frame(width: 200)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4),lineWidth: 1)
        )
    }
}
