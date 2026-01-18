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
        SceneDelegate.getAppCoordinator()?.openAccountInformationScene()
    }
    
    func openMyDocumentsScene() {
        SceneDelegate.getAppCoordinator()?.openMyDocumentsScene()
    }
    
    func openMarketsInsightScene() {
        SceneDelegate.getAppCoordinator()?.openMarketsInsightScene()
    }
    
    func openAlertsScene() {
        SceneDelegate.getAppCoordinator()?.openAlertsScene()
    }
    
    func openAccountStatementsScene() {
        SceneDelegate.getAppCoordinator()?.openAccountStatementsScene()
    }
    
    func openCashDepositScene() {
        SceneDelegate.getAppCoordinator()?.openCashDepositScene()
    }
    
    func openEquityTransferScene() {
        SceneDelegate.getAppCoordinator()?.openEquityTransferScene()
    }
    
    func openTransferScene() {
        SceneDelegate.getAppCoordinator()?.openTransfersScene()
    }
    
    func openClientPortalScene() {
        SceneDelegate.getAppCoordinator()?.openClientPortalScene()
    }
    
    func openIpoScene() {
        SceneDelegate.getAppCoordinator()?.openIPOScene()
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
