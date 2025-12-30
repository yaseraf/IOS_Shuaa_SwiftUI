//
//  BalanceDetailsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
class BalanceDetailsViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: PortfolioUseCaseProtocol

    @Published var userData: GetUserAccountsUIModel?
    @Published var portfolioData: GetPortfolioUIModel?

    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?
    
    init(coordinator: ManageCoordinatorProtocol, useCase: PortfolioUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        userData = UserDefaultController().selectedUserAccount

    }
}

// MARK: Mock Data
extension BalanceDetailsViewModel {
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
        
    }
}

// MARK: Routing
extension BalanceDetailsViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }

}

// MARK: API Calls
extension BalanceDetailsViewModel {
    func callGetPortfolioAPI(success: Bool) {
                
        let requestModel = GetPortfolioRequestModel()
        getPortfolioAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getPortfolio(requestModel: requestModel) {[weak self] result in
                self?.getPortfolioAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    debugPrint("Success to get user portfolio")
                        self?.getPortfolioAPIResult = .onSuccess(response: success)
                    
                    self?.portfolioData = success
                    
                case .failure(let failure):
                        debugPrint("Failed to get user portfolio")
                        self?.getPortfolioAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}

extension BalanceDetailsViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
        callGetPortfolioAPI(success: true)
    }
}
