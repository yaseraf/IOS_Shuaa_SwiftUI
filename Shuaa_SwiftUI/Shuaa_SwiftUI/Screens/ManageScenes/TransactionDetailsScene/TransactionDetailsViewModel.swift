//
//  TransactionDetailsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 07/08/2025.
//

import Foundation
class TransactionDetailsViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
 
    @Published var transactionAmount: String?
    @Published var fromAccount: String?
    @Published var status: TransactionStatus?
    @Published var statusDesc: String?
    @Published var transactionType: String?
    @Published var transactionDate: String?
    
    init(coordinator: ManageCoordinatorProtocol, transactionAmount: String, fromAccount: String?, status: TransactionStatus?, statusDesc: String?, transactionType: String?, transactionDate: String?) {
        self.coordinator = coordinator
        self.transactionAmount = transactionAmount
        self.fromAccount = fromAccount
        self.status = status
        self.statusDesc = statusDesc
        self.transactionType = transactionType
        self.transactionDate = transactionDate
    }
    
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
}
