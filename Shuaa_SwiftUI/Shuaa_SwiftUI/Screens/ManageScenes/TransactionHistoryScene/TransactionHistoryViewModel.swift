//
//  TransactionDetailsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 07/08/2025.
//

import Foundation
class TransactionHistoryViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol

    @Published var GetB2bRequestsAPIResult:APIResultType<[GetB2bRequestUIModel]>?
    @Published var GetShareTransferLogWithDetailsAPIResult:APIResultType<[GetShareTransferLogWithDetailsUIModel]>?
    
    @Published var userData: GetUserAccountsUIModel?
    @Published var transactionsHistoryData: [GetB2bRequestUIModel]?
    
    @Published var amount = "0"

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        userData = UserDefaultController().selectedUserAccount

        transactionsHistoryData = []
    }
}

// Routing
extension TransactionHistoryViewModel {
    
    func openTransactionDetailsScene(transactionData: GetB2bRequestUIModel) {
        coordinator.openTransactionDetailsScene(transactionAmount: transactionData.TRANSFER_AMOUNT ?? "", fromAccount: transactionData.FROM_ACC_NAME, status: transactionData.REQ_STATUS?.lowercased() ?? "" == "p" ? .pending : .approved, statusDesc: AppUtility.shared.isRTL ? transactionData.REQ_STATUS_DESC_AR : transactionData.REQ_STATUS_DESC, transactionType: AppUtility.shared.isRTL ? transactionData.REQ_TYPE_DESC_AR : transactionData.REQ_TYPE_DESC, transactionDate: transactionData.REQ_DATE)
    }
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }

    func onBackTap() {
        coordinator.popViewController()
    }
}

// API Calls
extension TransactionHistoryViewModel {
    func callGetB2bRequestsModel(success:Bool) {
        
        let requestModel = GetB2bRequestsRequestModel()
        
        GetB2bRequestsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetB2bRequests(requestModel: requestModel) {[weak self] result in
                self?.GetB2bRequestsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.GetB2bRequestsAPIResult = .onSuccess(response: success)
                    
                    self?.transactionsHistoryData = success
                    
                    self?.callGetShareTransferLogWithDetailsAPI(success: true)

                case .failure(let failure):
                        self?.GetB2bRequestsAPIResult = .onFailure(error: failure)
                    debugPrint("get expected profit loss sec failure: \(failure)")

                }
            }
        }
    }
    
    func callGetShareTransferLogWithDetailsAPI(success:Bool) {
        
        let requestModel = GetShareTransferLogWithDetailsRequestModel()
        
        GetShareTransferLogWithDetailsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetShareTransferLogWithDetails(requestModel: requestModel) {[weak self] result in
                self?.GetShareTransferLogWithDetailsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.GetShareTransferLogWithDetailsAPIResult = .onSuccess(response: success)
                    
                    for (_, item) in success.enumerated() {
                        self?.transactionsHistoryData?.append(GetB2bRequestUIModel(FROM_ACC_NAME: item.details?.first?.FROM_ACC_NAME, REQ_DATE: item.reqDate, REQ_STATUS: item.reqStatus, REQ_STATUS_DESC: item.reqStatusDesc, REQ_STATUS_DESC_AR: item.reqStatusDescAr, REQ_TYPE: item.requestId, REQ_TYPE_DESC: item.reqTypeDesc, REQ_TYPE_DESC_AR: item.reqTypeDescAr, TRANSFER_AMOUNT: String(item.details?.first?.QTY ?? 0)))
                    }
                    
                    self?.transactionsHistoryData = self?.transactionsHistoryData?.sorted {
                        $0.REQ_DATE ?? "" > $1.REQ_DATE ?? ""
                    }

                case .failure(let failure):
                        self?.GetShareTransferLogWithDetailsAPIResult = .onFailure(error: failure)
                    debugPrint("get expected profit loss sec failure: \(failure)")

                }
            }
        }
    }
}

// MARK: Delegates

extension TransactionHistoryViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
    }
}

