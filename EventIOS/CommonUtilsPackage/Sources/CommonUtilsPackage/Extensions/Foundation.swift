//
//  Foundation.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
