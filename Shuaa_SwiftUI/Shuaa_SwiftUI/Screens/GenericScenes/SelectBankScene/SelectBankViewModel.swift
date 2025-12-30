//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class SelectBankViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    private let delegate: SelectBankDelegate
    
    @Published var selectedBank: GetBankIBANUIModel?
    @Published var banksData: [BankUIModel]?
    
    @Published var banksList: [GetBankIBANUIModel]?
    
    init(coordinator: GenericCoordinatorProtocol, delegate: SelectBankDelegate, selectedBank: GetBankIBANUIModel?, banksList: [GetBankIBANUIModel]?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.selectedBank = selectedBank
        self.banksList = banksList
    }
}

// MARK: Mock Data
extension SelectBankViewModel {
    func getBanksData() {
        var bankData: [BankUIModel] = []
        bankData.append(BankUIModel(bankNumber: "XXXX-0011-1111"))
        bankData.append(BankUIModel(bankNumber: "QA39-xxxx-7777)"))
        bankData.append(BankUIModel(bankNumber: "QA79-xxxx-1110"))
       

        banksData = bankData
    }
}

// MARK: Routing
extension SelectBankViewModel {
    func onDismiss() {
        coordinator.dismiss()
    }

}

// MARK: API Calls
extension SelectBankViewModel {
    
}

// MARK: Functions
extension SelectBankViewModel {
    func onConfirm(bank: GetBankIBANUIModel?) {
        delegate.onSelect(bank: bank)
        coordinator.dismiss()
    }
}
