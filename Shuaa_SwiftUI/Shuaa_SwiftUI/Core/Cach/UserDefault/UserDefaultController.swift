//
//  UserDefaultController.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum CachingKey: String {

    // MARK: Bools
    
    case isLoggedIn
    case isPreviewMode
    case isDarkMode
    case isArabicLanguage
    case isUserInactive
    case isAutoLogin
    case isFirstLogin
    case isHeadHorizontalMovement
    case canRestartScreen
    case hasCheckedInactivity
    case priceAlertOption
    case signalRConnected
    case isMarketPrice
    case isBiometricEnabled
    case isPinEnabled
    case isRemeberMe
    case isCompaniesLogoEnabled
    case isClassificationBySectorEnabled
    
    // MARK: Strings
    
    case appLanguage
    case currentDeviceLanguage
    case sessiontimeoutPerSec
    case username
    case lastColorScheme
    case marketStatusCode
    case nameFullNameE
    case nameFullNameA
    case profileID
    case marketStatusTitle
    case selectedSymbol
    case selectedSymbolType
    case isMarketOpen
    case iconPath
    case BackgroundWatchList
    case searchResultSymbol
    case selectedMarket
    case exchangeID
    case dateFrom
    case dateTo
    case notificationAction
    case alertCriteria
    case alertName
    case alertId
    case profileName

    // For Alert
    case alertValidity
    case alertCondition
    case alertConditionName
    case alertConditionValue
    case alertCustomMsg

    
    // For Risk Management
    case orderType
    case qty
    case price
    case orderId
    case VALIDITYCODE
    case VALIDITY
    case SETT_TYPE
    case CUSTODYID
    
    // For Calculates Shares
    case cash
    
    // MARK: Other
    
    case appTheme
    case selectedUserAccount
    case tifList

}

class UserDefaultController: ObservableObject {
    static var instance: UserDefaultController = UserDefaultController()
    
    // MARK: Bools
    
    @CachingCodable<Bool>(.isDarkMode) var isDarkMode
    @CachingCodable<Bool>(.isLoggedIn) var isLoggedIn
    @CachingCodable<Bool>(.isPreviewMode) var isPreviewMode
    @CachingCodable<Bool>(.isUserInactive) var isUserInactive
    @CachingCodable<Bool>(.isAutoLogin) var isAutoLogin
    @CachingCodable<Bool>(.canRestartScreen) var canRestartScreen
    @CachingCodable<Bool>(.hasCheckedInactivity) var hasCheckedInactivity
    @CachingCodable<Bool>(.isFirstLogin) var isFirstLogin
    @CachingCodable<Bool>(.isHeadHorizontalMovement) var isHeadHorizontalMovement
    @CachingCodable<Bool>(.priceAlertOption) var priceAlertOption
    @CachingCodable<Bool>(.signalRConnected) var signalRConnected
    @CachingCodable<Bool>(.isMarketPrice) var isMarketPrice
    @CachingCodable<Bool>(.isBiometricEnabled) var isBiometricEnabled
    @CachingCodable<Bool>(.isPinEnabled) var isPinEnabled
    @CachingCodable<Bool>(.isRemeberMe) var isRememberMe
    @CachingCodable<Bool>(.isCompaniesLogoEnabled) var isCompaniesLogoEnabled
    @CachingCodable<Bool>(.isClassificationBySectorEnabled) var isClassificationBySectorEnabled
    
    // MARK: Strings

    @CachingCodable<String>(.appLanguage) var appLanguage
    @CachingCodable<String>(.currentDeviceLanguage) var currentDeviceLanguage
    @CachingCodable<String>(.sessiontimeoutPerSec) var sessiontimeoutPerSec
    @CachingCodable<String>(.username) var username
    @CachingCodable<String>(.lastColorScheme) var lastColorScheme
    @CachingCodable<String>(.marketStatusCode) var marketStatusCode
    @CachingCodable<String>(.nameFullNameA) var nameFullNameA
    @CachingCodable<String>(.nameFullNameE) var nameFullNameE
    @CachingCodable<String>(.profileID) var profileID
    @Published var marketStatusTitle: String? {
        didSet { marketStatusTitleCache = marketStatusTitle }
    }

    @CachingCodable<String>(.marketStatusTitle) private var marketStatusTitleCache
    @CachingCodable<String>(.selectedSymbol) var selectedSymbol
    @CachingCodable<String>(.selectedSymbolType) var selectedSymbolType
    @CachingCodable<String>(.isMarketOpen) var isMarketOpen
    @CachingCodable<String>(.iconPath) var iconPath
    @CachingCodable<String>(.BackgroundWatchList) var BackgroundWatchList
    @CachingCodable<String>(.searchResultSymbol) var searchResultSymbol
    @CachingCodable<String>(.selectedMarket) var selectedMarket
    @CachingCodable<String>(.exchangeID) var exchangeID
    @CachingCodable<String>(.orderType) var orderType
    @CachingCodable<String>(.qty) var qty
    @CachingCodable<String>(.price) var price
    @CachingCodable<String>(.orderId) var orderId
    @CachingCodable<String>(.VALIDITYCODE) var VALIDITYCODE
    @CachingCodable<String>(.VALIDITY) var VALIDITY
    @CachingCodable<String>(.SETT_TYPE) var SETT_TYPE
    @CachingCodable<String>(.CUSTODYID) var CUSTODYID
    @CachingCodable<String>(.dateFrom) var dateFrom
    @CachingCodable<String>(.dateTo) var dateTo
    @CachingCodable<String>(.alertValidity) var alertValidity
    @CachingCodable<String>(.alertCondition) var alertCondition
    @CachingCodable<String>(.alertConditionName) var alertConditionName
    @CachingCodable<String>(.alertConditionValue) var alertConditionValue
    @CachingCodable<String>(.notificationAction) var notificationAction
    @CachingCodable<String>(.alertCriteria) var alertCriteria
    @CachingCodable<String>(.alertName) var alertName
    @CachingCodable<String>(.alertId) var alertId
    @CachingCodable<String>(.profileName) var profileName
    @CachingCodable<String>(.cash) var cash

    // MARK: Others

    @CachingCodable<GetUserAccountsUIModel>(.selectedUserAccount) var selectedUserAccount
    @CachingCodable<ThemeType>(.appTheme) var appTheme
    @CachingCodable<[GetLookupsUIModel]>(.tifList) var tifList
        
    var isArabicLanguage: Bool {
        get {
            return appLanguage == LanguageType.arabic.rawValue
        }
    }
    
    func clearTempData(){
        profileID = nil
        signalRConnected = nil
        marketStatusTitle = nil
        selectedSymbol = nil
        selectedSymbolType = nil
        selectedUserAccount = nil
        isMarketOpen = nil
        orderType = nil
        qty = nil
        price = nil
        orderId = nil
        VALIDITYCODE = nil
        VALIDITY = nil
        SETT_TYPE = nil
        CUSTODYID = nil
        dateFrom = nil
        dateTo = nil
        tifList = nil
        alertValidity = nil
        alertCondition = nil
        alertConditionName = nil
        alertConditionValue = nil
        notificationAction = nil
        alertCriteria = nil
        alertName = nil
        alertId = nil
        isMarketPrice = nil
        profileName = nil
        cash = nil
        isPreviewMode = nil
    }
}


@propertyWrapper struct CachingCodable<T: Codable> {
    let key: CachingKey
    let storege: UserDefaults
    init(_ key: CachingKey, storege: UserDefaults = .userDefaultApp) {
        self.key = key
        self.storege = storege
    }
    
    var wrappedValue: T? {
        get{
            do {
                if let data = storege.value(forKey: key.rawValue) as? Data{
                    let value = try JSONDecoder().decode(T.self, from: data)
                    return value
                }
            }catch{
//                debugPrint( "UserDefaultController get value error:\(error)")
                
            }
            return nil
        }
        set{
            do {
                
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                storege.set(data, forKey: key.rawValue)
            }
            catch{
                debugPrint( "UserDefaultController set value error:\(error)")
            }
        }
    }
}

extension UserDefaults {
    static var userDefaultApp: UserDefaults {
        let userDefault = UserDefaults.standard
        userDefault.addSuite(named: AppUtility.bundleIdentifier)
        return userDefault
    }
}
