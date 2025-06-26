//
//  Foundation.swift
//  Event Watch App
//
//  Created by Duong Tuan on 16/06/2025.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
