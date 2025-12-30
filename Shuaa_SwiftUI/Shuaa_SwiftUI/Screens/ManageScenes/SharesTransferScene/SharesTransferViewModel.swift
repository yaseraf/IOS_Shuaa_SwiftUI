//
//  CashInViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
class SharesTransferViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol
    
    @Published var userData: GetUserAccountsUIModel?
    @Published var selectedShare: GetCompaniesLookupsUIModel?
    @Published var transactionAmount: String = ""
    @Published var cost: String = ""
    @Published var availableShares: Double = 0
    @Published var selectedTypeOfTransaction: TypeOfTransaction = .stockUplift
    @Published var expectedProfitLossForShare: GetExpectedProfitLossSecUIModel?

    @Published var SubmitShareTransferReqAPIResult:APIResultType<SubmitShareTransferReqUIModel>?
    @Published var GetExpectedProfitLossSecAPIResult:APIResultType<[GetExpectedProfitLossSecUIModel]>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        userData = UserDefaultController().selectedUserAccount
        
        selectedTypeOfTransaction = .stockUplift

    }
}

// MARK: Mock Data
extension SharesTransferViewModel {
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
    }
}

// MARK: Routing
extension SharesTransferViewModel {
    func openSelectSharesScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectSharesScene(delegate: self)
    }
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
    
    func onBackTap() {
//        coordinator.popViewController()
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openCancelConfirmationScene(transactionType: .shareTransfer)
    }
    
    func openTransactionDetailsScene() {
//        coordinator.popViewController()
//        coordinator.openTransactionDetailsScene(transactionAmount: transactionAmount, fromAccount: userData ?? .testUIModel(), transactionType: .shareTransfer)
    }
}

// MARK: API Calls
extension SharesTransferViewModel {
    func callSubmitShareTransferReqAPI(success:Bool) {
        
        let requestModel = SubmitShareTransferReqRequestModel(
            USR_CODE: Double(KeyChainController().webCode ?? ""),
            REQUEST_ID: selectedTypeOfTransaction == .stockUplift ? 22 : 23,
            MAIN_CLIENT_ID: Double(KeyChainController().mainClientID ?? ""),
            SEQ_REQ_ID: 1,
            REQ_DATE_STR: Date().toString(dateFormat: .ddMMyyyyHHmmss),
            REQ_TYPE: selectedTypeOfTransaction == .stockUplift ? 1 : 2,
            FROM_ACC: Double(KeyChainController().clientID ?? ""),
            TO_ACC: 0,
            FROM_ACC_TYPE: selectedTypeOfTransaction == .stockUplift ? "-1" : UserDefaultController().selectedUserAccount?.CL_CLIENT_TYPE ?? "",
            TO_ACC_TYPE: selectedTypeOfTransaction == .stockUplift ? UserDefaultController().selectedUserAccount?.CL_CLIENT_TYPE ?? "" : "-1",
            M_CODE: UserDefaultController().exchangeID ?? "",
            COMP_ID: expectedProfitLossForShare?.compID ?? "",
            QTY: Double(transactionAmount),
            CLOSE_PRICE: Double(cost),
        )
        
        SubmitShareTransferReqAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.SubmitShareTransferReq(requestModel: requestModel) {[weak self] result in
                self?.SubmitShareTransferReqAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
//                    self?.SubmitShareTransferReqAPIResult = .onSuccess(response: success)
                    
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "shares_transfer_success".localized)

                    self?.coordinator.popViewController()

//                    self?.openTransactionDetailsScene()
                    
                case .failure(let failure):
                        self?.SubmitShareTransferReqAPIResult = .onFailure(error: failure)
                    debugPrint("submit share transfer req failure: \(failure)")

                }
            }
        }
    }
    
    func callGetExpectedProfitLossSecAPI(success:Bool) {
        
        let requestModel = GetExpectedProfitLossSecRequestModel()
        
        GetExpectedProfitLossSecAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetExpectedProfitLossSec(requestModel: requestModel) {[weak self] result in
                self?.GetExpectedProfitLossSecAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.GetExpectedProfitLossSecAPIResult = .onSuccess(response: success)
                    
                    self?.expectedProfitLossForShare = success.filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first
                    
                    self?.availableShares = self?.expectedProfitLossForShare?.qty ?? 0
                    
                case .failure(let failure):
                        self?.GetExpectedProfitLossSecAPIResult = .onFailure(error: failure)
                    debugPrint("get expected profit loss sec failure: \(failure)")

                }
            }
        }
    }
}

// MARK: Delegates
extension SharesTransferViewModel: SelectSharesDelegate {
    func onSelect(share: GetCompaniesLookupsUIModel?) {
        selectedShare = share
        UserDefaultController().selectedSymbol = share?.symbol
        callGetExpectedProfitLossSecAPI(success: true)
    }
}

extension SharesTransferViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}
