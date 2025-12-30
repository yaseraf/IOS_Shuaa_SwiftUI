//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class SelectPortfolioViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    private let delegate: SelectPortfolioDelegate
    private let useCase: HomeUseCaseProtocol
    
    @Published var selectedUser: GetUserAccountsUIModel?
    @Published var usersData: [GetUserAccountsUIModel]?
    
    @Published var getUserAccountsAPIResult:APIResultType<[GetUserAccountsUIModel]>?

    init(coordinator: GenericCoordinatorProtocol, delegate: SelectPortfolioDelegate, useCase: HomeUseCaseProtocol, selectedUser: GetUserAccountsUIModel?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.useCase = useCase
        self.selectedUser = selectedUser
    }
        
}

// MARK: Routing
extension SelectPortfolioViewModel {
    
}

// MARK: Mock Data
extension SelectPortfolioViewModel {
    func getUsersData() {
    }

}

// MARK: API Calls
extension SelectPortfolioViewModel {
    func callGetUserAccountsAPI() {
                
        let requestModel = GetUserAccountsRequestModel()
        
        getUserAccountsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getUserAccounts(requestModel: requestModel) {[weak self] result in
                self?.getUserAccountsAPIResult = .onLoading(show: false)

                switch result {
                case .success(let success):
                        self?.getUserAccountsAPIResult = .onSuccess(response: success)
                    
                    self?.usersData = success
                    
                    debugPrint("Get user accounts success")
                    
                case .failure(let failure):
                        self?.getUserAccountsAPIResult = .onFailure(error: failure)
                    debugPrint("Get user accounts failure")
                }
            }
        }
        
        
    }

}


// MARK: Functions
extension SelectPortfolioViewModel {
    func onConfirm(user: GetUserAccountsUIModel?) {
        UserDefaultController().selectedUserAccount = user
        KeyChainController().clientID = user?.ClientID
        KeyChainController().mainClientID = user?.MainClientID
        KeyChainController().accountID = user?.AccountID
        KeyChainController().nin = user?.NIN
        
        delegate.onSelect(user: user)
        coordinator.dismiss()
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
}
