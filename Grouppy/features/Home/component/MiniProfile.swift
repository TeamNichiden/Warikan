//
//  ProfileHeaderView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI



struct MiniProfile: View {
    
    var body: some View {
        HStack {
            Circle() /*アイコンを表示*/
                .fill(Color(.systemGray5))
                .frame(width:80)
                .padding(.horizontal,30)
            
            HStack {
                VStack(alignment: .leading,spacing: 10) {
                    Text(MockData.authUser.name)
                        .fontWeight(.bold)
                        .font(.title2)
                    Text("@\(MockData.authUser.userId)")
                        .foregroundColor(.gray)
                        .font(.body)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MiniProfile()
}
