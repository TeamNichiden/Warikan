//
//  ProfileHeaderView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/07.
//

import SwiftUI



struct ProfileHeaderView: View {
    
    var body: some View {
        HStack {
            Spacer()
            Circle()
                .frame(width:80)
            
            Spacer()
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    Text(UserModel.sampleModel.name)
                    Text(UserModel.sampleModel.userID)
                        .foregroundColor(.gray)
                    
                }
                
                Spacer()
                
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
    }
}

#Preview {
    ProfileHeaderView()
}
