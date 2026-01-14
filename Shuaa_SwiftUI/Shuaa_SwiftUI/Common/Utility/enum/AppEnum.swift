//
//  AppEnum.swift
//  Shuaa
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

// ===================================
// MARK: LanguageType

enum LanguageType: String {
    case arabic = "ar"
    case english = "en"
    
    var text:String {
        self.rawValue.localized
    }

    var textShort:String {
       "\( self.rawValue)2".localized
    }
}

// ===================================
// MARK: ThemeType

enum ThemeType: String,Codable {
    case light = "light"
    case dark = "dark"
    case system = "system_settings"

    var text:String {
        self.rawValue.localized
    }
}

// ===================================
// MARK: LoginState

enum loginState {
    static let success = 0
    static let invalidLogin = -1
    static let invalidTokenID = -2
    static let tokenSent = -3
    static let tokenExpire = -4
    static let noPermetions = -5
    static let userLocked = -6
    static let anotherUserLogin = -7
    static let userNotAgreeTermCondtion = -8
    static let unknowError = -10
}

// ===================================
// MARK: HomeTabBarItem

enum HomeTabBarItem {
    case home
    case orderList
    case trade
    case accounts
    case portfolio

    var title:String {
        get{
            switch self {
            case .home:
                "home".localized
            case .orderList:
                "order_list".localized
            case .trade:
                "trade".localized
            case .accounts:
                "accounts".localized
            case .portfolio:
                "portfolio".localized
            }
        }
    }
    var iconName:String {
        get{
            switch self {
            case .home:
                "ic_home".localized
            case .orderList:
                "ic_orderList".localized
            case .trade:
                "ic_trades".localized
            case .accounts:
                "ic_accounts".localized
            case .portfolio:
                "ic_portfolio".localized
            }

        }
    }

}

// ===================================
// MARK: BackgroundType

enum BackgroundType {
    case gradient
    case gradientPreviewOrder
    case white
    case colorBGSecondary
    case blackWithAlpha
    case clear
    case quaternary
}

// ===================================
// MARK: Network

enum Network: String {
    case wifi = "en0"
    case cellular = "pdp_ip0"
    case ipv4 = "ipv4"
    case ipv6 = "ipv6"
}

// ===================================
// MARK: TopStocksType

enum TopStocksType {
    case topGainers
    case topLosers
    case topTurnover
    case topVolume
    case topTrades
}

// ===================================
// MARK: OrderType

enum OrderType {
    case buy
    case sell
}
