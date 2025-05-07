//
//  HomeView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI


struct HomeView: View {
    //MARK: TEST
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack {
            
            //MARK: PROFILE
            ProfileHeaderView()
            
            
            Spacer()
            
            //MARK: GROUP
            VStack(alignment: .leading) {
                Text("グループ管理")
                    .fontWeight(.bold)
                groupControllerStyle(btnImg: "plus.circle.fill", title: "グリープ作成", message: "新しいグループを作成する")
                groupControllerStyle(btnImg: "list.dash", title: "グループ確認", message: "所属グループを作成する")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        
        
    }
}

extension View {
    func groupControllerStyle(btnImg:String, title: String, message: String) -> some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: btnImg)
                    .font(.system(size: 40))
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .padding(.bottom,8)
                Text(message)
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .frame(width:UIScreen.main.bounds.width / 2)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray,lineWidth: 1)
        )
    }
}

#Preview {
    HomeView()
}
