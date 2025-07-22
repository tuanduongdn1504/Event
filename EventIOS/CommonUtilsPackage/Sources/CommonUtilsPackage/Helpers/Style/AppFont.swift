//
//  AppFont.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import SwiftUI

enum FontAvenirNextType:String {
    case regular = "AvenirNext-Regular"
    case ultraLightItalic = "AvenirNext-UltraLightItalic"
    case ultraLight = "AvenirNext-UltraLight"
    case italic = "AvenirNext-Italic"
    case medium = "AvenirNext-Medium"
    case mediumItalic = "AvenirNext-MediumItalic"
    case bold = "AvenirNext-Bold"
    case boldItalic = "AvenirNext-BoldItalic"
    case demiBold = "AvenirNext-DemiBold"
    case demiBoldItalic = "AvenirNext-DemiBoldItalic"
    case heavy = "AvenirNext-Heavy"
    case heavyItalic = "AvenirNext-HeavyItalic"
}

extension Font {
    static func avenirNext(size: CGFloat,
                           type: FontAvenirNextType = .regular) -> Font{
        self.custom(type.rawValue, size: size)
    }
}
