//
//  Color+Extension.swift
//  Shuaa
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: String) {
        var hexString = hex
        if hexString.contains("#" ) {
            hexString = hexString.replacingOccurrences(of: "#", with: "")
        }
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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
    func uiColor() -> UIColor {
            return UIColor(self)
        }
}
extension Color {
    static let userGradientsColor:[Color] = [Color.init(hex: "E0D8FB"), Color.init(hex: "B39CFF")]
}

//=======================================
//=======================================
//=======================================
// MARK: Light Color Codes

extension Color {
    private static let colorPrimaryLight: Color = Color.init(hex: "#22438A")
    private static let colorBaseLight: Color = Color.init(hex: "#FFFFFF")
    private static let colorGreenLight: Color = Color.init(hex: "#0FBE00")
    private static let colorRedLight: Color = Color.init(hex: "#EB0600")
    private static let colorBlueLight: Color = Color.init(hex: "#63AAD5")
    private static let colorSymbolLight: Color = Color.init(hex: "#FFFFFF")
    private static let colorSymbolSecondaryLight: Color = Color.init(hex: "#22438A")
    private static let colorSymbolPrimaryLight: Color = Color.init(hex: "#22438A")
    private static let colorTextFieldLight: Color = Color.init(hex: "#537387")
    private static let colorTextPrimaryLight: Color = Color.init(hex: "#0A3754")
    private static let colorTextSecondaryLight: Color = Color.init(hex: "#8E8E8E")
    private static let colorBackgroundLight: Color = Color.init(hex: "#0A3754")
    private static let colorBackgroundSecondaryLight: Color = Color.init(hex: "#FFFFFF")
    private static let colorBackgroundTertiaryLight: Color = Color.init(hex: "#3B5F76")
    private static let colorBorderLight: Color = Color.init(hex: "#FFFFFF")
    private static let colorBannerLight: Color = Color.init(hex: "#F7F7F7")
}

//=======================================
//=======================================
//=======================================
// MARK: Dark Color Codes

extension Color {
    private static let colorPrimaryDark: Color = Color.init(hex: "#D1D3D4")
    private static let colorBaseDark: Color = Color.init(hex: "#000000")
    private static let colorGreenDark: Color = Color.init(hex: "#0FBE00")
    private static let colorRedDark: Color = Color.init(hex: "#EB0600")
    private static let colorBlueDark: Color = Color.init(hex: "#63AAD5")
    private static let colorSymbolDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorSymbolSecondaryDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorSymbolPrimaryDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorTextFieldDark: Color = Color.init(hex: "#5D5E5F")
    private static let colorTextPrimaryDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorTextSecondaryDark: Color = Color.init(hex: "#8C8E8E")
    private static let colorBackgroundDark: Color = Color.init(hex: "#18191B")
    private static let colorBackgroundSecondaryDark: Color = Color.init(hex: "#242625")
    private static let colorBackgroundTertiaryDark: Color = Color.init(hex: "#454749")
    private static let colorBorderDark: Color = Color.init(hex: "#242625")
    private static let colorBannerDark: Color = Color.init(hex: "#2A2D2C")
}

//=======================================
//=======================================
//=======================================
// MARK: Multi-Color Codes

extension Color {
    static let colorSuccess_26A95F: Color = Color.init(hex: "#26A95F")
    static let colorBGTertiary_333A41: Color = Color.init(hex: "#333A41")
    static let colorBGPrimary_161E26: Color = Color.init(hex: "161E26")
    static let colorTextPlaceHolder_94989C: Color = Color.init(hex: "#94989C")
    static let colorSuccess50_092A18: Color = Color.init(hex: "#092A18")
    static let colorSuccess_56D990: Color = Color.init(hex: "#56D990")
    static let colorWarning50_4E1D09: Color = Color.init(hex: "#4E1D09")
    static let colorWarning600_FDB022: Color = Color.init(hex: "#FDB022")
    static let colorFGQuaternary_CED0D2: Color = Color.init(hex: "#CED0D2")
    static let colorTextDisable_85898E: Color = Color.init(hex: "#85898E")
    private static let colorSuccess50_EEFBF4: Color = Color.init(hex: "#EEFBF4")
    private static let colorFGPrimary_101C28: Color = Color.init(hex: "#101C28")
    private static let colorBGTertiary_F2F4F7: Color = Color.init(hex: "#F2F4F7")
    private static let colorTextPlaceHolder_667585: Color = Color.init(hex: "#667585")
    private static let colorBGPrimary_FFFFFF: Color = Color.init(hex: "#FFFFFF")
    private static let colorError_D92D20: Color = Color.init(hex: "#FF3B30")
    private static let colorQuaternary_61666C: Color = Color.init(hex: "#61666C")
    private static let colorQuaternary_EAEDF0: Color = Color.init(hex: "#EAEDF0")
    private static let colorBGSecondary_1F272F: Color = Color.init(hex: "#1F272F")
    private static let colorBGSecondary_F9FAFB: Color = Color.init(hex: "#F9FAFB")
    private static let colorChartGreen_2DCA72: Color = Color.init(hex: "#2DCA72")
    private static let colorWarning600_DC6803: Color = Color.init(hex: "#DC6803")
    private static let colorWarning200_FEDF89: Color = Color.init(hex: "#FEDF89")
    private static let colorWarning50_FFFAE: Color = Color.init(hex: "#FFFAEB")
    private static let colorError50_FEF3F2: Color = Color.init(hex: "#FEF3F2")
    private static let colorFGPrimary_FFFFFF: Color = Color.init(hex: "#FFFFFF")
    private static let colorFGQuaternary_667585: Color = Color.init(hex: "#667585")
    private static let colorTextDisable_667585: Color = Color.init(hex: "#667585")
}

//=======================================
//=======================================
//=======================================
//  MARK: Properties with getters
extension Color {
    static var colorPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorPrimaryDark : colorPrimaryLight
        }
    }
    
    static var colorBase: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBaseDark : colorBaseLight
        }
    }
        
    static var colorGreen: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorGreenDark : colorGreenLight
        }
    }
    
    static var colorRed: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorRedDark : colorRedLight
        }
    }
    
    static var colorBlue: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBlueDark : colorBlueLight
        }
    }
    
    static var colorSymbol: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSymbolDark : colorSymbolLight
        }
    }
    
    static var colorSymbolSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSymbolSecondaryDark : colorSymbolSecondaryLight
        }
    }
    
    static var colorSymbolPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSymbolPrimaryDark : colorSymbolPrimaryLight
        }
    }
    
    static var colorTextField: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextFieldDark : colorTextFieldLight
        }
    }
    
    static var colorTextPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextPrimaryDark : colorTextPrimaryLight
        }
    }
    
    static var colorTextSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextSecondaryDark : colorTextSecondaryLight
        }
    }
    
    static var colorBackground: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBackgroundDark : colorBackgroundLight
        }
    }
    
    static var colorBorderPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBorderDark : colorBorderLight
        }
    }

    
    static var colorBackgroundSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBackgroundSecondaryDark : colorBackgroundSecondaryLight
        }
    }
    
    static var colorBackgroundTertiary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBackgroundTertiaryDark : colorBackgroundTertiaryLight
        }
    }
    
    static var colorBanner: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBannerDark : colorBannerLight
        }
    }
    
    //=======================================
    //=======================================
    //=======================================
    // MARK: Multi-Color Codes
        
    static var colorBorder: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBorderDark : colorBorderLight
        }
    }
    
    static var colorTextPrimaryHEX: String {
        get {
            AppUtility.shared.isDarkTheme ? "F5F5F6" : "101C28"
        }
    }
    
    static var colorError: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorError_D92D20 : colorError_D92D20
        }
    }

    static var colorError700: Color {
        get {
            Color(hex: "FDA29B")
        }
    }

    static var colorBlack: Color {
        get {
            AppUtility.shared.isDarkTheme ? Color.white : Color.black
        }
    }
    
    static var colorQuaternary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorQuaternary_61666C : colorQuaternary_EAEDF0
        }
    }

    static var colorBGSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGSecondary_1F272F : colorBGSecondary_F9FAFB
        }
    }
    
    static var colorBGPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGPrimary_161E26 : colorBGPrimary_FFFFFF
        }
    }

    static var colorTextPlaceHolder: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextPlaceHolder_94989C : colorTextPlaceHolder_667585
        }
    }
    
    static var colorBGTertiary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGTertiary_333A41 : colorBGTertiary_F2F4F7
        }
    }

    static var colorSuccess: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSuccess50_092A18 : colorSuccess_26A95F
        }
    }

    static var colorSuccess2: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorChartGreen_2DCA72 : colorSuccess_26A95F
        }
    }

    static var colorSuccess50: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSuccess_56D990 : colorSuccess50_EEFBF4
        }
    }
    
    static var colorWarning600: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning600_DC6803 : colorWarning600_DC6803
        }
    }

    static var colorWarning200: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning50_4E1D09 : colorWarning200_FEDF89
        }
    }


    static var colorWarning50: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning600_FDB022 : colorWarning50_FFFAE
        }
    }

    static var colorError50: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorError50_FEF3F2 : colorError50_FEF3F2
        }
    }

    static var colorFGPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorFGPrimary_FFFFFF : colorFGPrimary_101C28
        }
    }

    static var colorFGQuaternary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorFGQuaternary_CED0D2 : colorFGQuaternary_667585
        }
    }

    static var colorTextDisable: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextDisable_85898E : colorTextDisable_667585
        }
    }

}
