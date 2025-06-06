//
//  ProfileHeaderView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI

struct MiniProfile: View {
    var user: AppUser
    
    var body: some View {
        HStack {
            // 用户头像
            ZStack {
                if let iconData = user.iconData, let uiImage = UIImage(data: iconData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if let iconUrl = user.iconUrl {
                    AsyncImage(url: iconUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle()
                            .fill(.cyan)
                    }
                } else {
                    Circle()
                        .fill(.cyan)
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .fontWeight(.bold)
                    .font(.title2)
                Text("@\(user.userId)")
                    .foregroundColor(.gray)
                    .font(.body)
            }
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    MiniProfile(
        user: AppUser(
            name: "山田 太郎", 
            email: "taro@example.com", 
            userId: "taro"
        )
    )
}
