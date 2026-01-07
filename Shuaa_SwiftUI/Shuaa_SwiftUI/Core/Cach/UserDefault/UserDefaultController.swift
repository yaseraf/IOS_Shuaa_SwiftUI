//
//  UserDefaultController.swift
//  Shuaa
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum CachingKey: String {
    
    //==============================
    // MARK: Int
    
    case standardFontSize
    case fontSizeChangeResult
    case fontSizeInterval

    //==============================
    // MARK: Bools
    
    case isDarkMode
    case signalRConnected
    case hasCheckedInactivity
    case isLoggedIn
    case canRestartScreen

    //==============================
    // MARK: Strings
    
    case appLanguage
    case currentDeviceLanguage
    case sessiontimeoutPerSec
    case lastColorScheme

    //==============================
    // MARK: Other
    
    case appTheme
}

class UserDefaultController: ObservableObject {
    static var instance: UserDefaultController = UserDefaultController()
        
    //==============================
    // MARK: Int
    @CachingCodable<Int>(.standardFontSize) var standardFontSize
    @CachingCodable<Int>(.fontSizeChangeResult) var fontSizeChangeResult
    @CachingCodable<Int>(.fontSizeInterval) var fontSizeInterval

    //==============================
    // MARK: Bools
    
    @CachingCodable<Bool>(.isDarkMode) var isDarkMode
    @CachingCodable<Bool>(.signalRConnected) var signalRConnected
    @CachingCodable<Bool>(.hasCheckedInactivity) var hasCheckedInactivity
    @CachingCodable<Bool>(.isLoggedIn) var isLoggedIn
    @CachingCodable<Bool>(.canRestartScreen) var canRestartScreen

    //==============================
    // MARK: Strings

    @CachingCodable<String>(.appLanguage) var appLanguage
    @CachingCodable<String>(.currentDeviceLanguage) var currentDeviceLanguage
    @CachingCodable<String>(.sessiontimeoutPerSec) var sessiontimeoutPerSec
    @CachingCodable<String>(.lastColorScheme) var lastColorScheme

    //==============================
    // MARK: Others

    @CachingCodable<ThemeType>(.appTheme) var appTheme
        
    var isArabicLanguage: Bool {
        get {
            return appLanguage == LanguageType.arabic.rawValue
        }
    }
    
    func clearTempData() {
        sessiontimeoutPerSec = ""
        hasCheckedInactivity = false

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
