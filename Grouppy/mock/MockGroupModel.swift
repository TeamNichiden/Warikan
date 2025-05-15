//
//  MockGroupModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import Foundation

class MockGroupModel: Identifiable, Hashable {
    let id = UUID()
    var groupName: String = ""
    var groupMemo: String = ""
    var dateStr: String = ""
    var palce: String = ""
    var member: [UserModel] = []
    
    // MARK: - Hashable
    static func == (lhs: MockGroupModel, rhs: MockGroupModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
