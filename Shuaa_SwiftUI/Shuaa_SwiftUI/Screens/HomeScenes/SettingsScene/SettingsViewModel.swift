//
//  SettingsViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import WebKit

class SettingsViewModel: ObservableObject {
    
    private let coordinator: AppCoordinatorProtocol
    
    @Published var fontSize = UserDefaultController().fontSizeChangeResult
    @Published var selectedLanguage:LanguageType
    @Published var selectedTheme:ThemeType

    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
        
        if AppUtility.shared.isRTL {
            selectedLanguage = .arabic
        } else {
            selectedLanguage = .english
        }
        
        if UserDefaultController().appTheme == .dark {
            selectedTheme = .dark
        } else {
            selectedTheme = .light
        }
    }
}

// MARK: Mock Data
extension SettingsViewModel {
    
}

// MARK: Routing
extension SettingsViewModel {
    
}

// MARK: API Calls
extension SettingsViewModel {
    
}

// MARK: Functions
extension SettingsViewModel {
    func onLanguageChange(newLanguage:LanguageType){
        selectedLanguage = newLanguage
        AppUtility.shared.updateAppLanguage(language: newLanguage)
        SceneDelegate.getAppCoordinator()?.restart()
    }
    
    func onAppThemeChange(type:ThemeType){
        UserDefaultController().appTheme = type
        selectedTheme = type
        SceneDelegate.getAppCoordinator()?.updateWindowBackground()
        SceneDelegate.getAppCoordinator()?.restart()
    }

    func onFontSizeIncrease() {
        if UserDefaultController().fontSizeInterval == 2 { return }
        
        UserDefaultController().fontSizeInterval = (UserDefaultController().fontSizeInterval ?? 0) + 1
        
        UserDefaultController().fontSizeChangeResult = (UserDefaultController().standardFontSize ?? 0) + (UserDefaultController().fontSizeInterval ?? 0)
        
        fontSize = UserDefaultController().fontSizeChangeResult
    }
    
    func onFontSizeDecrease() {
        if UserDefaultController().fontSizeInterval == -1 { return }

        UserDefaultController().fontSizeInterval = (UserDefaultController().fontSizeInterval ?? 0) - 1
        
        UserDefaultController().fontSizeChangeResult = (UserDefaultController().standardFontSize ?? 0) + (UserDefaultController().fontSizeInterval ?? 0)
        
        fontSize = UserDefaultController().fontSizeChangeResult
    }

}

// MARK: SignalRs
extension SettingsViewModel {
    
}

// MARK: Delegates


