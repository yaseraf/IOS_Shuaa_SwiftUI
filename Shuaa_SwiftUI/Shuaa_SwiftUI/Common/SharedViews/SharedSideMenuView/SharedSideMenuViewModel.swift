//
//  SharedSideMenuViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 07/01/2026.
//

import Foundation

class SharedSideMenuViewModel: ObservableObject {
 
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
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.openSettingsScene()
    }
    
    func onLogout() {
        SceneDelegate.getAppCoordinator()?.logout()
    }

}
