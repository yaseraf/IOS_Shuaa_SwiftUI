//
//  SharedSideMenuViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 07/01/2026.
//

import Foundation

class SharedSideMenuViewModel: ObservableObject {
    
    static let shared = SharedSideMenuViewModel()
    
    @Published var isMenuOpen:Bool = false
    
    init() {
        SharedHeaderViewViewModel.shared.sideMenuDelegate = self
    }
}

// MARK: Routing
extension SharedSideMenuViewModel {
    func openAccountInformationScene() {
        
    }
    
    func openMyDocumentsScene() {

    }
    
    func openMarketsInsightScene() {

    }
    
    func openMyAlertsScene() {

    }
    
    func openAccountStatementsScene() {

    }
    
    func openCashDepositScene() {

    }
    
    func openEquityTransferScene() {

    }
    
    func openTransferScene() {

    }
    
    func openClientPortalScene() {

    }
    
    func openIpoScene() {

    }
    
    func openSettingsScene() {
        SceneDelegate.getAppCoordinator()?.openSettingsScene()
    }
}

// MARK: Functions
extension SharedSideMenuViewModel {
    func onLogout() {
        SceneDelegate.getAppCoordinator()?.logout()
    }
}

// MARK: Delegates
extension SharedSideMenuViewModel: SideMenuDelegate {
    func openMenu() {
        isMenuOpen = true
    }
    
    func closeMenu() {
        isMenuOpen = false
    }
}
