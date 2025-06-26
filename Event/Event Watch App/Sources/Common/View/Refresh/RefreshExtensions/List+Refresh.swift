//
//  List+Refresh.swift
//  Event Watch App
//
//  Created by Duong Tuan on 16/06/2025.
//

import Foundation
import SwiftUI

extension ScrollView {
    
    public func enableRefresh(_ enable: Bool = true) -> some View {
        modifier(Refresh.Modifier(enable: enable))
    }
}
