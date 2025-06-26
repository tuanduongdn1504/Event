//
//  RefreshFooterKey.swift
//  Event Watch App
//
//  Created by Duong Tuan on 16/06/2025.
//

import SwiftUI

extension EnvironmentValues {
    
    var refreshFooterUpdate: Refresh.FooterUpdateKey.Value {
        get { self[Refresh.FooterUpdateKey.self] }
        set { self[Refresh.FooterUpdateKey.self] = newValue }
    }
}
extension Refresh {
    
    struct FooterAnchorKey {
        static var defaultValue: Value = []
    }
    
    struct FooterUpdateKey {
        static var defaultValue: Value = .init(enable: false)
    }
}
extension Refresh.FooterAnchorKey: PreferenceKey {
    
    typealias Value = [Item]
    
    struct Item {
        let bounds: Anchor<CGRect>
        let preloadOffset: CGFloat
        let refreshing: Bool
    }
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}
extension Refresh.FooterUpdateKey: EnvironmentKey {
    
    struct Value: Equatable {
        let enable: Bool
        var refresh: Bool = false
    }
}
