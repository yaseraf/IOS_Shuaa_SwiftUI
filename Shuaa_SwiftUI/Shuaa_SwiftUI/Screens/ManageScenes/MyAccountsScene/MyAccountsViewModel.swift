//
//  CashInViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
class MyAccountsViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    
    @Published var userData: GetUserAccountsUIModel?
    @Published var selectedBank: GetBankIBANUIModel?
    @Published var selectedCountry: CountryUIModel?
    @Published var myAccounts: [AccountsUIModel]?

    init(coordinator: ManageCoordinatorProtocol) {
        self.coordinator = coordinator
        
        userData = UserDefaultController().selectedUserAccount

    }
    
    func onBackTap() {
//        coordinator.popViewController()
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openCancelConfirmationScene(transactionType: .cashIn)
    }
    
    func onSendRequest() {
        coordinator.popViewController()
    }
    
    func getMyAccountsData() {
        var data: [AccountsUIModel] = []
        
        data.append(AccountsUIModel(logo: "ic_qnbLogo", accountNameE: "Qatar Islamic Bank", accountNameA: "مصرف قطر الإسلامي", swiftCode: "QISBQAQA", iban: "QA11-XXXX-0111", stateE: "Qatar", stateA: "قطر", status: "inactive_account".localized))
        data.append(AccountsUIModel(logo: "ic_qnbLogo", accountNameE: "Qatar Islamic Bank", accountNameA: "مصرف قطر الإسلامي", swiftCode: "QISBQAQA", iban: "QA11-XXXX-0112", stateE: "Qatar", stateA: "قطر", status: "active_account".localized))
        data.append(AccountsUIModel(logo: "ic_qnbLogo", accountNameE: "Qatar Islamic Bank", accountNameA: "مصرف قطر الإسلامي", swiftCode: "QISBQAQA", iban: "QA11-XXXX-0113", stateE: "Qatar", stateA: "قطر", status: "active_account".localized))
        
        myAccounts = data
    }
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
    
    func openSelectBankScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectBankScene(delegate: self, selectedBank: selectedBank, banksList: [])
    }
}

extension MyAccountsViewModel: SelectBankDelegate {
    func onSelect(bank: GetBankIBANUIModel?) {
        selectedBank = bank
    }
}

extension MyAccountsViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}
