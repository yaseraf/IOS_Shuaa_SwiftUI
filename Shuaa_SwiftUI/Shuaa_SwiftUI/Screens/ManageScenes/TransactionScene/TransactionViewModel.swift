//
//  TransactionViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
class TransactionsViewModel:ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    
    init(coordinator: ManageCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func openCashInScene() {
        coordinator.openCashInScene()
    }
    
    func openCashOutScene() {
        coordinator.openCashOutScene()
    }
    
    func openSharesTransferScene() {
        coordinator.openSharesTransferScene()
    }
    
    func openMyAccountsScene() {
        coordinator.openMyAccountsScene()
    }
    
    func openTransactionsHistoryScene() {
        coordinator.openTransactionHistoryScene()
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
}
