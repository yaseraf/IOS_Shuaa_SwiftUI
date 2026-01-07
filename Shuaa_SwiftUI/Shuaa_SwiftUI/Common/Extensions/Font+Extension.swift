//
//  Font+Extension.swift
//  Shuaa
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
extension Font {
    
    enum ThemeFont {
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        case black
        var value: String {
            switch self {
            case .thin:
                "NotoSansArabic-Thin"
            case .extraLight:
                "NotoSansArabic-ExtraLight"
            case .light:
                "NotoSansArabic-Light"
            case .regular:
                "NotoSansArabic-Regular"
            case .medium:
                "NotoSansArabic-Medium"
            case .semiBold:
                "NotoSansArabic-SemiBold"
            case .bold:
                "NotoSansArabic-Bold"
            case .extraBold:
                "NotoSansArabic-ExtraBold"
            case .black:
                "NotoSansArabic-Black"
            }
        }
    }
    
    enum PTSansThemeFont {
        case regular
        case medium
        case semiBold
        case bold
        var value: String {
            switch self {
            case .regular:
                AppUtility.shared.isRTL ? "DroidArabicKufi-Regular" : "PTSans-Regular"
            case .medium:
                AppUtility.shared.isRTL ? "DroidArabicKufi-Regular" : "PTSans-Regular"
            case .semiBold:
                AppUtility.shared.isRTL ? "DroidArabicKufi-Regular" : "PTSans-Bold"
            case .bold:
                AppUtility.shared.isRTL ? "DroidArabicKufi-Regular" : "PTSans-Bold"
            }
        }
    }
    
    static func apply(_ type: Font.PTSansThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.value, size: CGFloat((UserDefaultController().fontSizeChangeResult ?? 0) - (UserDefaultController().standardFontSize ?? 0)) + size)
    }
    
    static func applyNoto(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.value, size: size)
    }
}

extension UIFont {
    static func apply(_ type: Font.PTSansThemeFont = .regular, size: CGFloat ) -> UIFont? {
        return UIFont(name: type.value, size: size)
    }
    
    static func applyNoto(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> UIFont? {
        return UIFont(name: type.value, size: size)
    }
}

