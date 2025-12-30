//
//  CashInViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
class CashInViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol
    
    @Published var userData: GetUserAccountsUIModel?
    @Published var selectedBank: GetBankIBANUIModel?
    
    @Published var transactionAmount: String = ""
    
    @Published var banksList: GetAccountTransferInfoUIModel?
    
    @Published var SubmitCrmRequestRamzAPIResult:APIResultType<SubmitCrmRequestRamzUIModel>?
    @Published var GetAccountTransferInfoAPIResult:APIResultType<GetAccountTransferInfoUIModel>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        userData = UserDefaultController().selectedUserAccount

    }
}

// MARK: Mock Data
extension CashInViewModel {
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
    }
}

// MARK: Routing
extension CashInViewModel {
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
    
    func openSelectBankScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectBankScene(delegate: self, selectedBank: selectedBank, banksList: [])
    }
    
    func onBackTap() {
//        coordinator.popViewController()
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openCancelConfirmationScene(transactionType: .cashIn)
    }
    
    func onSendRequest() {
//        coordinator.popViewController()
//        coordinator.openTransactionDetailsScene(transactionAmount: transactionAmount, fromAccount: userData ?? .testUIModel(), transactionType: .cashIn)
    }
}

// MARK: API Calls
extension CashInViewModel {
    func callSubmitCrmRequestRamzAPI(success:Bool) {
        
        let requestModel = SubmitCrmRequestRamzRequestModel(ACCOUNT_NAME: "", AMOUNT: "", AVILABLE_BALANCE: 0, AccountTo: "", B2B_CHEQUES: "", B2B_CHEQUES_DEFAULT: "", B2B_TRANSFER: "", B2B_TRANSFER_DEFAULT: "", BANK_ACC_GL_NO: "", BANK_ACC_NO: "", BANK_CODE: "", BANK_NAME: "", BankName: "", BranchName: "", CASH: 0, CHEQUE_DATE: "", CLIENT_ID: "", CLIENT_ID_TO: "", CURRENCY: "", CURRENCY_RATE: "", CURR_ACC_BANK_ID: "", CURR_ACC_CURRANCY: "", DESCIPTION: "", FROM_ACC_ID: "", IBAN: "", INVEST_ACC_BANK_ID: "", IS_REPRESINTITIVE: "", Is_Same_Currency: "", MAIN_CLIENT_ID: "", PAYEE_NAME: "", REPRESINTITIVE_ID: "", REQUEST_DATE: "", REQ_APPROVAL_STATUS: "", REQ_CONFIRM: "", REQ_ID: "", REQ_TYPR: "", STATUS: "", Swift_code: "", TO_ACC_ID: "", TRANSFERABLE_BALANCE: 0, TransferNote: "", TransferNoteAr: "", TransferType: "", UserCode: "", VirtualAccount: "", WEB_CODE: "")
        
        /*
         
         {
           "WEB_CODE": "666",
           "MAIN_CLIENT_ID": "1800101017561",
           "REQUEST_DATE": "", // Empty
           "FROM_ACC_ID": "2017561",
           "AMOUNT": "1000",
           "TO_ACC_ID": "",
           "REQ_TYPR": "2", // Check notes in my teams chat
           "STATUS": "P", // Check object nedal sent 
           "BANK_CODE": "",
           "BANK_NAME": "",
           "BANK_ACC_NO": "",
           "CHEQUE_DATE": "",
           "PAYEE_NAME": "164 / ABDULLA KHALIFA A ALATTIYAH",
           "BANK_ACC_GL_NO": "",
           "IS_REPRESINTITIVE": "",
           "REPRESINTITIVE_ID": "",
           "IBAN": "",
           "CURRENCY": "QAR",
           "Swift_code": ""
         }
         
         */
        
        SubmitCrmRequestRamzAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.SubmitCrmRequestRamz2(requestModel: requestModel) {[weak self] result in
                self?.SubmitCrmRequestRamzAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.SubmitCrmRequestRamzAPIResult = .onSuccess(response: success)
                    

                    
                case .failure(let failure):
                        self?.SubmitCrmRequestRamzAPIResult = .onFailure(error: failure)
                    debugPrint("Edit watchlist list failure: \(failure)")

                }
            }
        }
    }
    
    func callGetAccountTransferInfoAPI(success:Bool) {
        
        let requestModel = GetAccountTransferInfoRequestModel(ACCOUNT_NAME: "", AMOUNT: "", AVILABLE_BALANCE: 0, AccountTo: "", B2B_CHEQUES: "", B2B_CHEQUES_DEFAULT: "", B2B_TRANSFER: "", B2B_TRANSFER_DEFAULT: "", BANK_ACC_GL_NO: "", BANK_ACC_NO: "", BANK_CODE: "", BANK_NAME: "", BankName: "", BranchName: "", CASH: 0, CHEQUE_DATE: "", CLIENT_ID: "", CLIENT_ID_TO: "", CURRENCY: "", CURRENCY_RATE: "", CURR_ACC_BANK_ID: "", CURR_ACC_CURRANCY: "", DESCIPTION: "", FROM_ACC_ID: "", IBAN: "", INVEST_ACC_BANK_ID: "", IS_REPRESINTITIVE: "", Is_Same_Currency: "", MAIN_CLIENT_ID: "", PAYEE_NAME: "", REPRESINTITIVE_ID: "", REQUEST_DATE: "", REQ_APPROVAL_STATUS: "", REQ_CONFIRM: "", REQ_ID: "", REQ_TYPR: "", STATUS: "", Swift_code: "", TO_ACC_ID: "", TRANSFERABLE_BALANCE: 0, TransferNote: "", TransferNoteAr: "", TransferType: "", UserCode: "", VirtualAccount: "", WEB_CODE: "")
        
        GetAccountTransferInfoAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetAccountTransferInfo(requestModel: requestModel) {[weak self] result in
                self?.GetAccountTransferInfoAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.GetAccountTransferInfoAPIResult = .onSuccess(response: success)
                    
                    self?.banksList = success
                    
                case .failure(let failure):
                        self?.GetAccountTransferInfoAPIResult = .onFailure(error: failure)
                    debugPrint("Edit watchlist list failure: \(failure)")

                }
            }
        }
    }
}


// MARK: Delegates
extension CashInViewModel: SelectBankDelegate {
    func onSelect(bank: GetBankIBANUIModel?) {
        selectedBank = bank
    }
}

extension CashInViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}
