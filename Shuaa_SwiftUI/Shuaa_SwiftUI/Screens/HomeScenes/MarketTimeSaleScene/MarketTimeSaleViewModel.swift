//
//  TopStocksViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

class MarketTimeSaleViewModel:ObservableObject {
    
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var marketsData: [MarketsUIModel]?

    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Mock Data
extension MarketTimeSaleViewModel {
    func getMarketsData() {
        marketsData = []
        marketsData?.append(.initMockData())
    }
}

// MARK: Routing
extension MarketTimeSaleViewModel {
    
}

// MARK: API Calls
extension MarketTimeSaleViewModel {
    
}

// MARK: Functions
extension MarketTimeSaleViewModel {
    
}

// MARK: SingalRs
extension MarketTimeSaleViewModel {
    
}

// MARK: Delegates
