//
//  PortfolioViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
class PortfolioViewModel: ObservableObject {
    private var coordinator: PortfolioCoordinatorProtocol
    private let useCase: PortfolioUseCaseProtocol
    
    @Published var userData: GetUserAccountsUIModel?
    @Published var portfolioData: GetPortfolioUIModel?

    @Published var getUserAccountsAPIResult:APIResultType<[GetUserAccountsUIModel]>?
    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?

    init(coordinator: PortfolioCoordinatorProtocol, useCase: PortfolioUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        userData = UserDefaultController().selectedUserAccount

//        Connection_Hub.shared.portfolioDelegate = self
    }
}

// MARK: Routing
extension PortfolioViewModel {
    func openTradeScene(symbol: String) {
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == symbol}).first ?? .testUIModel()
        UserDefaultController().selectedSymbol = symbol
        UserDefaultController().selectedSymbolType = selectedStock.marketType
        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().openTradeScene(stock: selectedStock, typeOfTrade: .sell, isEditOrder: false, orderDetails: .initializer())
    }
    
    func openShareDetails(symbol: String) {
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == symbol}).first ?? .testUIModel()
        UserDefaultController().selectedSymbol = symbol
        UserDefaultController().selectedSymbolType = selectedStock.marketType

        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openShareDetailsScene()
    }
    func openSelectPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPortfolioScene(delegate: self, selectedUser: userData)
    }
}

// MARK: Mock Data
extension PortfolioViewModel {
    func getPortfolioData() {
//        var data: [PortfolioUIModel] = []
//        
//        data.append(PortfolioUIModel(symbol: "QNBK", nameEn: "QNB", nameAr: "بنك القطري", image: "ic_QNBK", volume: 5000, available: 5000, marketValue: 4.252, avgPrice: 4.011, value: 180000.02, cost: 20055.04, netPnL: 4.011, achievedPnL: -2.1))
//        data.append(PortfolioUIModel(symbol: "Ahli Bank", nameEn: "ABQK", nameAr: "بنك الأهلي", image: "ic_ABQK", volume: 5000, available: 5000, marketValue: 4.252, avgPrice: 4.011, value: 120000.02, cost: 20055.04, netPnL: 4.011, achievedPnL: 2.2))
//        data.append(PortfolioUIModel(symbol: "Doha Insurance", nameEn: "DOHI", nameAr: "مجموعة الدوحة للتأمين", image: "ic_DOHI", volume: 5000, available: 5000, marketValue: 4.252, avgPrice: 4.011, value: 180000.02, cost: 20055.04, netPnL: 4.011, achievedPnL: -2.3))
//        data.append(PortfolioUIModel(symbol: "Dukhan Bank", nameEn: "DUBK", nameAr: "بنك دخان", image: "ic_DUBK", volume: 5000, available: 5000, marketValue: 4.252, avgPrice: 4.011, value: 180000.02, cost: 20055.04, netPnL: 4.011, achievedPnL: 2.55))
//        data.append(PortfolioUIModel(symbol: "Qatar Islamic Bank", nameEn: "QIBK", nameAr: "المصرف", image: "ic_DUBK", volume: 5000, available: 5000, marketValue: 4.252, avgPrice: 4.011, value: 180000.02, cost: 20055.04, netPnL: 4.011, achievedPnL: 2.4))
//        
//        portfolioData = data
    }
    
    func getUserData() {
//        userData = UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134)
    }
}

// MARK: API Calls
extension PortfolioViewModel {
//    func callGetPortfolioAPI(success: Bool) {
//                
//        let requestModel = GetPortfolioRequestModel()
//        getPortfolioAPIResult = .onLoading(show: true)
//        
//        Task.init {
//            await useCase.getPortfolio(requestModel: requestModel) {[weak self] result in
//                self?.getPortfolioAPIResult = .onLoading(show: false)
//                switch result {
//                case .success(let success):
//                    
//                    debugPrint("Success to get user portfolio")
//                        self?.getPortfolioAPIResult = .onSuccess(response: success)
//                    
//                    self?.portfolioData = success
//                    
//                case .failure(let failure):
//                        debugPrint("Failed to get user portfolio")
//                        self?.getPortfolioAPIResult = .onFailure(error: failure)
//               
//                }
//            }
//        }
//    }

    func callGetUserAccountsAPI(success: Bool) {
                
        let requestModel = GetUserAccountsRequestModel()
        
        getUserAccountsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getUserAccounts(requestModel: requestModel) {[weak self] result in

                switch result {
                case .success(let success):
                        self?.getUserAccountsAPIResult = .onSuccess(response: success)
                    
                    if KeyChainController.shared().clientID != nil && KeyChainController.shared().clientID != "" && KeyChainController.shared().mainClientID != nil && KeyChainController.shared().mainClientID != "" && UserDefaultController().selectedUserAccount?.AccType != "all" {
                        self?.callGetPortfolioAPI(success: true)
//                        self?.GetPortfolioSignalR()
                        debugPrint("Calling portfolio 1")
                    }
                    
                    if UserDefaultController().selectedUserAccount == nil ||  UserDefaultController().selectedUserAccount?.ClientID == "" || UserDefaultController().selectedUserAccount?.AccType == "all" {
                        for item in success {
                            if item.IS_DEFAULT_ACC == "Y" {
                                UserDefaultController().selectedUserAccount = item
                                KeyChainController.shared().clientID = item.ClientID
                                KeyChainController.shared().mainClientID = item.MainClientID
                                KeyChainController.shared().accountID = item.AccountID
                                self?.callGetPortfolioAPI(success: true)
//                                self?.GetPortfolioSignalR()
                                debugPrint("Calling portfolio 2")
                            }
                        }
                    }
                    
                    
                    debugPrint("Get user accounts success")
                    
                case .failure(let failure):
                        self?.getUserAccountsAPIResult = .onFailure(error: failure)
                    debugPrint("Get user accounts failure")
                }
            }
        }
        
        
    }
    
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
//                    self?.getChartData()
                    
//                    self?.totalCostValue = 0
//                    self?.totalMarketValue = 0
//                    self?.totalPnLValue = 0
                    
//                    if self?.selectGetUserAccountsUIModel.AccType == "all" {
//                        for portfolioItem in success.portfolioes {
//                            self?.totalCostValue += portfolioItem.locBookedPSValue ?? 0
//                            self?.totalMarketValue += portfolioItem.locNValue ?? 0
//                            self?.totalPnLValue += Double(portfolioItem.profitLossInAED ?? "") ?? 0
//                        }
//                    }
                    
                case .failure(let failure):
                        debugPrint("Failed to get user portfolio")
                        self?.getPortfolioAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}

// MARK: SignalR
extension PortfolioViewModel {
    func GetPortfolioSignalR() {
        if Connection_Hub.shared.chatHub != nil {
            do {
                //                try Connection_Hub.shared.chatHub?.invoke("GetPortfolio", arguments: ["1000106940463", "2948859", "82", "-1", "1010", "F"]) { (result, error) in

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.getPortfolio.rawValue, arguments: [KeyChainController().mainClientID ?? "", KeyChainController().clientID ?? "", "1140", "-1", KeyChainController().brokerID ?? "", "F"]) { (result, error) in
                    if let e = error {
                        printToLog("SignalR GetPortfolio invoke Error: \(e)")
                        self.getPortfolioAPIResult = .onLoading(show:  false)

                    } else {
                        debugPrint("SignalR GetPortfolio invoke Success! - result: \(result)")
                        self.getPortfolioAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                printToLog("SignalR GetPortfolio chatHub error: \(error.localizedDescription)")
                self.getPortfolioAPIResult = .onLoading(show:  false)
            }
        } else {
            debugPrint("Chathub is nil")
        }
    }
}

// MARK: Delegates

//extension PortfolioViewModel: PortfolioDelegate {
//    func onPortfolioReceive(data: [GetPortfolioSignalRUIModel]) {
//        portfolioData = data
//    }
//}

extension PortfolioViewModel: SelectPortfolioDelegate {
    func onSelect(user: GetUserAccountsUIModel?) {
        userData = user
        
        callGetPortfolioAPI(success: true)
    }
}
