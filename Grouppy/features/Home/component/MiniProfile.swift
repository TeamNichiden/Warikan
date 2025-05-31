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
      Circle() /*アイコンを表示*/
        .fill(.cyan)
        .frame(width: 80)
        .padding(.trailing, 8)

      HStack {
        VStack(alignment: .leading) {
          Text(user.name)
            .fontWeight(.bold)
            .font(.title2)
          Text("@\(user.userId)")
            .foregroundColor(.gray)
            .font(.body)
        }
      }
      Spacer()
    }
    .padding(.horizontal, 8)
  }
}

#Preview {
  MiniProfile(
    user: AppUser(
        id: UUID(), name: "山田 太郎", email: "taro@example.com", userId: "taro", iconUrl: nil))
}
