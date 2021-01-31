//
//  InterFontModifier.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

enum InterFont_Type {
    case black
    case bold
    case extraBold
    case extraLight
    case light
    case medium
    case regular
    case semiBold
    case thin
}

func getInterFont(type: InterFont_Type) -> String {
    switch(type) {
    case .black:
        return "Inter-Black"
    case .bold:
        return "Inter-Bold"
    case .extraBold:
        return "Inter-ExtraBold"
    case .extraLight:
        return "Inter-ExtraLight"
    case .light:
        return "Inter-Light"
    case .medium:
        return "Inter-Medium"
    case .regular:
        return "Inter-Regular"
    case .semiBold:
        return "Inter-SemiBold"
    case .thin:
        return "Inter-Thin"
    }
}

struct InterFont: ViewModifier {
    
    var type: InterFont_Type
    var size: CGFloat
    
    init(_ type: InterFont_Type = .regular, size: CGFloat = 16) {
        self.type = type
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content.font(getFont())
    }
    
    func getFont() -> Font {
        switch(type) {
        case .black:
            return Font.custom("Inter-Black", size: size)
        case .bold:
            return Font.custom("Inter-Bold", size: size)
        case .extraBold:
            return Font.custom("Inter-ExtraBold", size: size)
        case .extraLight:
            return Font.custom("Inter-ExtraLight", size: size)
        case .light:
            return Font.custom("Inter-Light", size: size)
        case .medium:
            return Font.custom("Inter-Medium", size: size)
        case .regular:
            return Font.custom("Inter-Regular", size: size)
        case .semiBold:
            return Font.custom("Inter-SemiBold", size: size)
        case .thin:
            return Font.custom("Inter-Thin", size: size)
        }
    }
}
