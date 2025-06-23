//
//  RefreshingView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 16/06/2025.
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
