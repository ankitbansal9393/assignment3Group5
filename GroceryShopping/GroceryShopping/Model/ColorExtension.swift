//
//  ColorExtension.swift
//  GroceryStore
//
//  Created by Daun Jeong on 3/5/2024.
//

import Foundation
import SwiftUI

// Color extension with hex initializer and color definitions
extension Color {
    static let mainBackgroundColor = Color(hex: "#E8ECEB")
    static let mainTextColor = Color(hex: "#2D3E4E")
    static let mainMintColor = Color(hex: "#8CBDB9")  // Defined color using hex code
    static let pointColor = Color(hex: "#E09E50")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// CGColor extension using Color definitions
extension CGColor {
    static let mainBackgroundColor = Color.mainBackgroundColor.cgColor
    static let mainTextColor = Color.mainTextColor.cgColor
    static let mainMintColor = Color.mainMintColor.cgColor  // Reference the Color definition
}

