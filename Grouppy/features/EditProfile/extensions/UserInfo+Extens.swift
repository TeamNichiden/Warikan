//
//  UserInfo+Extens.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/09.
//
import SwiftUI

extension View {
    func infoRowView(
        title:String,
        inputText:Binding<String>,
        isEditable:Bool = true,
        submitLabel:String? = nil,
        submitAction:(() -> Void)? = nil
    ) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            HStack {
                TextField("",text: inputText)
                    .foregroundColor(isEditable ? .black : .gray)
                    .disabled(!isEditable)
                if !isEditable {
                    if let submitLabel = submitLabel, let submitAction = submitAction {
                        Button {
                            submitAction()
                        } label: {
                            Text(submitLabel)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}
