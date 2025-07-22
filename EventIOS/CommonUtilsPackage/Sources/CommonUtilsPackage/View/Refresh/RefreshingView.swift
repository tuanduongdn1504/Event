//
//  RefreshingView.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import SwiftUI

struct RefreshingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryColor))
            .cornerRadius(15)
            .shadow(radius: 10)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
    }
}
