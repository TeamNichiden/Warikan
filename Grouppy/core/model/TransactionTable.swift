//
//  TransactionTable.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/02.
//

import Foundation

struct TransactionTable: Identifiable {
    let id: UUID
    var title: String
    var totalAmount: Int
    var payee: AppUser?
    var payers: [AppUser]?
    var memo: String
    
    init(id: UUID = UUID(), title: String, totalAmount: Int, payee: AppUser? = nil, payers: [AppUser]? = nil, memo: String) {
        self.id = id
        self.title = title
        self.totalAmount = totalAmount
        self.payee = payee
        self.payers = payers
        self.memo = memo
    }
}
