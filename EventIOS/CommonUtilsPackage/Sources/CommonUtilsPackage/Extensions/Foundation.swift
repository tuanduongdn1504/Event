//
//  Foundation.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
