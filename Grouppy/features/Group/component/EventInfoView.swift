//
//  GroupInfoView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

extension View {
    func EventInfoView(date: String, place: String, memo: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("日時：")
                    .fontWeight(.bold)
                Text(date)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("場所：")
                    .fontWeight(.bold)
                Text(place)
            }
            HStack {
                Text("メモ：")
                    .fontWeight(.bold)
                Text(memo)
            }
        }
    }
}
