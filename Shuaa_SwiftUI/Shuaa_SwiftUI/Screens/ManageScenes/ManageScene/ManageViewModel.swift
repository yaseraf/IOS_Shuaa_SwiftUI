//
//  ManageViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import WebKit

class ManageViewModel: ObservableObject {
    
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var newsData: [GetAllMarketNewsBySymbolUIModel]?
    @Published var fontSize = UserDefaultController().fontSizeChangeResult
    @Published var selectedLanguage:LanguageType
    @Published var selectedTheme:ThemeType

    init(coordinator: HomeCoordinatorProtocol) {
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
    
    func openSettingScene() {
        coordinator.openSettingScene()
    }
    
    func logout() {
        // Stop SignalR connection
        Connection_Hub.shared.connection?.stop()
        
        // Clear hub references
        Connection_Hub.shared.connection?.hubs.removeAll()
        
        // Remove from global connection list
        if let connection = Connection_Hub.shared.connection,
           let index = SwiftR.connections.firstIndex(where: { $0 === connection }) {
            SwiftR.connections.remove(at: index)
        }
        
        // Release WKWebView
        Connection_Hub.shared.connection?.wkWebView.removeFromSuperview()
        Connection_Hub.shared.connection?.wkWebView = nil
        
        // Optional: clear cookies & cache
        WKWebsiteDataStore.default().removeData(
            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
            modifiedSince: Date.distantPast
        ) {
            print("✅ SignalR completely disconnected and cleaned up")
        }
        
        // Reset singleton reference
        Connection_Hub.shared.connection = nil
        
        SceneDelegate.getAppCoordinator()?.logout()
    }

}

// MARK: Functions
extension ManageViewModel {
    func onLanguageChange(newLanguage:LanguageType){
        selectedLanguage = newLanguage
        AppUtility.shared.updateAppLanguage(language: newLanguage)
        SceneDelegate.getAppCoordinator()?.restartLanguageUpdate()
        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().start()
    }
    
    func onAppThemeChange(type:ThemeType){
        UserDefaultController().appTheme = type
        selectedTheme = type
        SceneDelegate.getAppCoordinator()?.updateWindowBackground()
        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().start()
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
