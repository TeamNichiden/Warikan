//
//  EventDetailView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import SwiftUI

extension View {
    func EventDetailView(date: String, place: String, memo: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("日時：")
                    .fontWeight(.bold)
                Text(date)
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
