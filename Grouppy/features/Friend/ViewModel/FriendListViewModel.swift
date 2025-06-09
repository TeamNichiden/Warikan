//
//  FriendListViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/08.
//
import SwiftUI
import Observation

@Observable
class FriendListViewModel {
    var shouldAddUsers: Bool = false
    var selectedUsers: Set<UUID> = []
    var inputText: String = ""
    var numOfUsers: Int = 0
    
    func createEvent() {
        if !selectedUsers.isEmpty {
            //メンバーを追加してEventテーブルを作成
        } else {
            //そのまま閉める
        }
    }
}
