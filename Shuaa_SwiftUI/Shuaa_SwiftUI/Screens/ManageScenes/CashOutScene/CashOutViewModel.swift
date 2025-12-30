//
//  CashInViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
class CashOutViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol

    @Published var userData: GetUserAccountsUIModel?
    @Published var selectedBank: GetBankIBANUIModel?
    @Published var transactionAmount: String = ""
    @Published var iban: String = ""
    @Published var availableBalance: Double?
    @Published var swiftCode: String = ""

    @Published var banksList: [GetBankIBANUIModel]?
    @Published var selectedTypeOfTransaction: TypeOfCashOutTransactions?
    
    @Published var SubmitCrmRequestRamzAPIResult:APIResultType<SubmitCrmRequestRamzUIModel>?
    @Published var GetAccountTransferInfoAPIResult:APIResultType<GetAccountTransferInfoUIModel>?
    @Published var GetBankIBANAPIResult:APIResultType<[GetBankIBANUIModel]>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        userData = UserDefaultController().selectedUserAccount
        selectedTypeOfTransaction = .chequeRequest
        banksList = []
    }
}

// MARK: Mock Data
extension CashOutViewModel {
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
    }

}

// MARK: Routing
extension CashOutViewModel {
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
    
    func openSelectBankScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectBankScene(delegate: self, selectedBank: selectedBank, banksList: banksList ?? [])
    }

    func onBackTap() {
//        coordinator.popViewController()
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openCancelConfirmationScene(transactionType: .cashOut)

    }
    
    func openTransactionDetailsScene() {
//        coordinator.popViewController()
//        coordinator.openTransactionDetailsScene(transactionAmount: transactionAmount, fromAccount: userData ?? .testUIModel(), transactionType: .cashOut)
    }

}

// MARK: API Calls
extension CashOutViewModel {
    func callSubmitCrmRequestRamz2API(success:Bool) {
        
        let payeeName = AppUtility.shared.isRTL ? UserDefaultController().selectedUserAccount?.ClientNameA : UserDefaultController().selectedUserAccount?.ClientNameE
        
        let requestModel = SubmitCrmRequestRamzRequestModel(
            ACCOUNT_NAME: "",
            AMOUNT: transactionAmount,
            AVILABLE_BALANCE: 0,
            AccountTo: "",
            B2B_CHEQUES: "",
            B2B_CHEQUES_DEFAULT: "",
            B2B_TRANSFER: "",
            B2B_TRANSFER_DEFAULT: "",
            BANK_ACC_GL_NO: "",
            BANK_ACC_NO: "",
            BANK_CODE: "",
            BANK_NAME: selectedTypeOfTransaction == .chequeRequest ? "" : selectedBank?.bankName ?? "",
            BankName: "",
            BranchName: "",
            CASH: 0,
            CHEQUE_DATE: "",
            CLIENT_ID: "",
            CLIENT_ID_TO: "",
            CURRENCY: UserDefaultController().selectedUserAccount?.CUR_CODE ?? "",
            CURRENCY_RATE: "",
            CURR_ACC_BANK_ID: "",
            CURR_ACC_CURRANCY: "",
            DESCIPTION: "",
            FROM_ACC_ID: KeyChainController().clientID ?? "",
            IBAN: selectedTypeOfTransaction == .chequeRequest ? "" : iban,
            INVEST_ACC_BANK_ID: "",
            IS_REPRESINTITIVE: "",
            Is_Same_Currency: "",
            MAIN_CLIENT_ID: KeyChainController().mainClientID ?? "",
            PAYEE_NAME: selectedTypeOfTransaction == .chequeRequest ? payeeName : "",
            REPRESINTITIVE_ID: "",
            REQUEST_DATE: "",
            REQ_APPROVAL_STATUS: "",
            REQ_CONFIRM: "",
            REQ_ID: "",
            REQ_TYPR: selectedTypeOfTransaction == .chequeRequest ? "2" : "3",
            STATUS: "P",
            Swift_code: selectedTypeOfTransaction == .chequeRequest ? "" : swiftCode,
            TO_ACC_ID: "",
            TRANSFERABLE_BALANCE: 0,
            TransferNote: "",
            TransferNoteAr: "",
            TransferType: "",
            UserCode: "",
            VirtualAccount: "",
            WEB_CODE: KeyChainController().webCode ?? ""
        )
        
        SubmitCrmRequestRamzAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.SubmitCrmRequestRamz2(requestModel: requestModel) {[weak self] result in
                self?.SubmitCrmRequestRamzAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.SubmitCrmRequestRamzAPIResult = .onSuccess(response: success)
                    
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "cash_out_success".localized)

                    self?.coordinator.popViewController()
                    
//                    self?.openTransactionDetailsScene()
                    
                case .failure(let failure):
                        self?.SubmitCrmRequestRamzAPIResult = .onFailure(error: failure)
                    debugPrint("submit crm request ramz2 failure: \(failure)")

                }
            }
        }
    }
    
    func callGetAccountTransferInfoAPI(success:Bool) {
        
        let requestModel = GetAccountTransferInfoRequestModel(
            ACCOUNT_NAME: "",
            AMOUNT: "",
            AVILABLE_BALANCE: 0,
            AccountTo: "",
            B2B_CHEQUES: "",
            B2B_CHEQUES_DEFAULT: "",
            B2B_TRANSFER: "",
            B2B_TRANSFER_DEFAULT: "",
            BANK_ACC_GL_NO: "",
            BANK_ACC_NO: "",
            BANK_CODE: "",
            BANK_NAME: "",
            BankName: "",
            BranchName: "",
            CASH: 0,
            CHEQUE_DATE: "",
            CLIENT_ID: KeyChainController().clientID ?? "",
            CLIENT_ID_TO: "",
            CURRENCY: UserDefaultController().selectedUserAccount?.CUR_CODE ?? "",
            CURRENCY_RATE: "",
            CURR_ACC_BANK_ID: "",
            CURR_ACC_CURRANCY: "",
            DESCIPTION: "",
            FROM_ACC_ID: "",
            IBAN: "",
            INVEST_ACC_BANK_ID: "",
            IS_REPRESINTITIVE: "",
            Is_Same_Currency: "",
            MAIN_CLIENT_ID: KeyChainController().mainClientID ?? "",
            PAYEE_NAME: "",
            REPRESINTITIVE_ID: "",
            REQUEST_DATE: "",
            REQ_APPROVAL_STATUS: "",
            REQ_CONFIRM: "",
            REQ_ID: "",
            REQ_TYPR: "",
            STATUS: "",
            Swift_code: "",
            TO_ACC_ID: "",
            TRANSFERABLE_BALANCE: 0,
            TransferNote: "",
            TransferNoteAr: "",
            TransferType: "",
            UserCode: "",
            VirtualAccount: "",
            WEB_CODE: KeyChainController().webCode ?? ""
        )
        
        GetAccountTransferInfoAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetAccountTransferInfo(requestModel: requestModel) {[weak self] result in
                self?.GetAccountTransferInfoAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.GetAccountTransferInfoAPIResult = .onSuccess(response: success)
                    
//                    self?.banksList = success
                    self?.availableBalance = success.AVILABLE_BALANCE ?? 0
                    
                case .failure(let failure):
                        self?.GetAccountTransferInfoAPIResult = .onFailure(error: failure)
                    debugPrint("get account transfer info failure: \(failure)")

                }
            }
        }
    }

    func callGetBankIBANAPI(success:Bool) {
        
        let requestModel = GetBankIBANRequestModel()
        
        GetBankIBANAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetBankIBAN(requestModel: requestModel) {[weak self] result in
                self?.GetBankIBANAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.GetBankIBANAPIResult = .onSuccess(response: success)
                    
                    self?.banksList = success

                    self?.swiftCode = success.first?.swiftCode ?? ""
                      
                case .failure(let failure):
                    self?.GetBankIBANAPIResult = .onFailure(error: failure)
                    debugPrint("get bank iban failure: \(failure)")
                }
            }
        }
    }
}

// MARK: Delegates
extension CashOutViewModel: SelectBankDelegate {
    func onSelect(bank: GetBankIBANUIModel?) {
        selectedBank = bank
        iban = bank?.iban ?? ""
        if selectedTypeOfTransaction == .wireTransfer {
//            callGetBankIBANAPI(success: true)
        }
    }
}

extension CashOutViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}
