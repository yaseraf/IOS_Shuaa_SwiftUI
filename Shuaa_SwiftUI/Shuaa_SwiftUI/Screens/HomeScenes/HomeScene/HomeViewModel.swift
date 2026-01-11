//
//  HomeViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    private var coordinator: HomeCoordinatorProtocol
    
    
    @Published var marketsData: [MarketsUIModel]?
    @Published var stocksData: [StocksUIModel]?
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
        
        UserDefaultController().isLoggedIn = true
        connectAndSetupSignalR()

    }
}

// MARK: Mock Data
extension HomeViewModel {
    func getMarketsData() {
        marketsData = []
        marketsData?.append(.initMockData())
    }
    
    func getStocksData() {
        var data: [StocksUIModel] = []
        
        data.append(StocksUIModel(stockName: "ETISALAT", lastTradePrice: 36.68, netChange: 0.100, netChangePerc: 10.00))
        data.append(StocksUIModel(stockName: "WATANIA", lastTradePrice: 0.650, netChange: -0.004, netChangePerc: -0.615))
        data.append(StocksUIModel(stockName: "ETISALAT", lastTradePrice: 36.68, netChange: 0.100, netChangePerc: 10.00))
        data.append(.initializer())
        data.append(.initializer())
        data.append(StocksUIModel(stockName: "WATANIA", lastTradePrice: 0.650, netChange: -0.004, netChangePerc: -0.615))
        data.append(.initializer())
        data.append(.initializer())
        data.append(.initializer())
        data.append(.initializer())
        data.append(.initializer())
        data.append(.initializer())
        
        stocksData = data
    }
    
}

// MARK: Routing
extension HomeViewModel {
    func openLoginScene() {
        SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
    }
    
    func openMarketOverviewScene() {
        coordinator.openMarketOverviewScene()
    }
    
    func openTopStocksScene() {
        coordinator.openTopStocksScene()
    }
}

// MARK: API CALLS
extension HomeViewModel {
    
}

// MARK: FUNCTIONS
extension HomeViewModel {
        
    func connectAndSetupSignalR() {
        if !Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.setupHubSignalR()
            Connection_Hub.shared.connection?.start()
        }
    }
    
}

// MARK: SignalRs
extension HomeViewModel {
    
}

// MARK: Delegates
