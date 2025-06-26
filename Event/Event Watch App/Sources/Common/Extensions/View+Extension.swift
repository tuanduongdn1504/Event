//
//  View+Extension.swift
//  Event Watch App
//
//  Created by Duong Tuan on 17/06/2025.
//

import SwiftUI

extension View {
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
