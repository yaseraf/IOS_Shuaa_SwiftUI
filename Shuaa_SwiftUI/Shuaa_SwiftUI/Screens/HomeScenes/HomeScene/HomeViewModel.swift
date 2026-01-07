//
//  HomeViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by Tawfeeq Irshaidat on 23/07/2025.
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
        var data: [MarketsUIModel] = []
        
        data.append(MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .MMMdd_yyyy_at_WithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04%", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254"))
        
        marketsData = data
    }
    
    func getStocksData() {
        var data: [StocksUIModel] = []
        
        data.append(StocksUIModel(stockName: "ETISALAT", lastTradePrice: "36.68", netChange: "0.100", netChangePerc: "10.00%"))
        data.append(StocksUIModel(stockName: "WATANIA", lastTradePrice: "0.650", netChange: "-0.004", netChangePerc: "-0.615%"))
        data.append(StocksUIModel(stockName: "ETISALAT", lastTradePrice: "36.68", netChange: "0.100", netChangePerc: "10.00%"))
        data.append(.initializer())
        data.append(.initializer())
        data.append(StocksUIModel(stockName: "WATANIA", lastTradePrice: "0.650", netChange: "-0.004", netChangePerc: "-0.615%"))
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
