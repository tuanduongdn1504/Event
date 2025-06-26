//
//  WatchService.swift
//  Event Watch App
//
//  Created by Duong Tuan on 15/06/2025.
//

import Foundation

@propertyWrapper
struct WatchService<Component> {
    var component: Component
    
    init(_ keyPath: KeyPath<WatchServiceContainer, Component>) {
        self.component = WatchServiceContainer.shared[keyPath: keyPath]
    }
    
    public var wrappedValue: Component {
        get { component }
        mutating set { component = newValue }
    }
}
