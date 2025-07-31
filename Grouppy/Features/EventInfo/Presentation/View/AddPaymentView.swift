//
//  addPaymentView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/02.
//

import SwiftUI

struct AddPaymentView: View {
    
    var body: some View {
        Text("")
        
    }
}

extension View {
    func AddPaymentRow(title: String, inputMessage: Binding<String>) -> some View {
        VStack {
            Text(title)
            TextField("", text: inputMessage)
        }
    }
}

#Preview {
    AddPaymentView()
}
