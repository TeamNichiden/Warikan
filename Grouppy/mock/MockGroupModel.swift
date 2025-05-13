//
//  MockGroupModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import Foundation

struct MockGroupModel {
    let id = UUID()
    var groupName: String = ""
    var groupMemo: String = ""
    var dateStr: String = ""
    var palce: String = ""
    var member: [UserModel] = []
}
