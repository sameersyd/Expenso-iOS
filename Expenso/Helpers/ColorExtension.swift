//
//  ColorExtension.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

extension Color {
    
    static let main_color = Color("main_color")
    static let primary_color = Color("primary")
    static let secondary_color = Color("secondary")
    static let text_primary_color = Color("textPrimary_33_F2")
    static let text_secondary_color = Color("textSecondary_4F_F2")
    static let placeholder_color = Color(UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0))
    
    static let main_green = Color(UIColor(red: 111/255, green: 207/255, blue: 151/255, alpha: 1.0))
    static let main_red = Color(UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 1.0))
    
    init(hex: String, alpha: Double = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        let scanner = Scanner(string: cString)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(.sRGB, red: Double(r) / 0xff, green: Double(g) / 0xff, blue:  Double(b) / 0xff, opacity: alpha)
    }
}
