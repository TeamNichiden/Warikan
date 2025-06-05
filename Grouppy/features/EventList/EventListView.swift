//
//  GroupListView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

struct EventListView: View {
    @StateObject var vm = EventListViewModel()
    @EnvironmentObject var route: NavigationRouter
    
    var body: some View {
        VStack {
            // ヘッダー部分
            headerView
            
            // 検索バー
            searchBar
            
            // イベントリスト
            eventListView
        }
        .padding(.horizontal)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Spacer()
            Button(action: {
                route.navigate(to: .addEvent)
            }) {
                addButton()
            }
        }
        .padding(.bottom)
    }
    
    private var searchBar: some View {
        TextField("検索", text: $vm.searchMessage)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
    }
    
    private var eventListView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                if !vm.filteredEventList.isEmpty {
                    ForEach(vm.filteredEventList) { event in
                        eventRow(for: event)
                    }
                } else {
                    Text("現在はイベントがありません")
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private func eventRow(for event: Event) -> some View {
        Button(action: {
            route.navigate(to: .event(id: event.id))
        }) {
            HStack {
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 5, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text(event.updatedAt.dateToString())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.trailing, 8)
            }
            .foregroundColor(.black)
            .background(Color(.systemGray6))
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 8,
                    topTrailingRadius: 8
                )
            )
        }
    }
}

#Preview {
    EventListView()
}
