//
//  View+Extension.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import SwiftUI

public extension View {
    func withToolbar(title: String? = nil) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBar(title: title)
                }
            }
    }
}
