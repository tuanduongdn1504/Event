//
//  List+Refresh.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import Foundation
import SwiftUI

extension ScrollView {
    
    public func enableRefresh(_ enable: Bool = true) -> some View {
        modifier(Refresh.Modifier(enable: enable))
    }
}
