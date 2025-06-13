//
//  Color+Extension.swift
//  Event Watch App
//
//  Created by Duong Tuan on 02/06/2025.
//

import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "#F90000")
    static let successDefaut = Color(hex: "#00C48C")
    static let successSoft = Color(hex: "#D5F2EA")
    static let mineShaft = Color(hex: "#373737")
    static let grey600 = Color(hex: "#727272")
    static let grey400 = Color(hex: "#BDBDBD")
    static let errorSoft = Color(hex: "#FFE1E1")
    static let grey50 = Color(hex: "#F6F6F6")
    static let grey200 = Color(hex: "#D0D0D0")
    static let appOrange = Color(hex: "#FFA400")
    static let redBackground = Color(hex: "#610326")
    static let redTextColor = Color(hex: "#E10071")
    static let greenBackground = Color(hex: "#00480C")
    static let greenTextColor = Color(hex: "#00E42F")
    static let yellowTextColor = Color(hex: "#E1C938")
    static let yellowBackgroundColor = Color(hex: "#8E701C")
    static let plusBackground = Color(hex: "#15382A")
}

// Optional: Hex support
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // Skip #

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

extension Image {
    func toIcon() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: 16)
    }
}
