//
//  FriendListRow 2.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/09.
//


//
//  FriendListRow.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/09.
//

import SwiftUI

struct AddUserSheetRow: View {
    let user: AppUser
    let isSelected: Bool
    let checkBox: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: user.iconUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.black.opacity(0.5), lineWidth: 2)
            )
            
            VStack(alignment: .leading) {
                Text(user.name)
                Text(user.email)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if checkBox {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
