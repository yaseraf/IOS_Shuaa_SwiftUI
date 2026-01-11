//
//  MarketOverviewViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

class MarketOverviewViewModel: ObservableObject {
    
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var marketsData: [MarketsUIModel]?
    @Published var indicesData: [MarketOverviewUIModel]?
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Mock Data
extension MarketOverviewViewModel {
    func getMarketsData() {
        marketsData = []
        marketsData?.append(.initMockData())
    }

    func getMarketOverviewData() {
        indicesData = MarketOverviewUIModel.initMockDataArray()
    }
}
