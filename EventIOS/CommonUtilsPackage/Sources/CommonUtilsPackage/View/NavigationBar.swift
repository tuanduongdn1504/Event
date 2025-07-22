//
//  NavigationBar.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    
    var title: String?

    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .frame(width: 20, height: 20)
            Text(title ?? "Back")
                .font(.avenirNext(size: 12, type: .medium))
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.black)
        .onTapGesture {
            dismiss()
        }
    }
}
