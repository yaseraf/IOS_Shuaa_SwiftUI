//
//  TopStocksViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

class TopStocksViewModel:ObservableObject {
    
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var marketsData: [MarketsUIModel]?
    @Published var topGainersData: [TopGainersUIModel]?
    @Published var topLosersData: [TopLosersUIModel]?
    @Published var topTurnoverData: [TopTurnoverUIModel]?
    @Published var topVolumeData: [TopVolumeUIModel]?
    @Published var topTradesData: [TopTradesUIModel]?

    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Mock Data
extension TopStocksViewModel {
    func getMarketsData() {
        marketsData = []
        marketsData?.append(.initMockData())
    }

    func getTopStocksData() {
        topGainersData = []
        topLosersData = []
        topTurnoverData = []
        topVolumeData = []
        topTradesData = []
        
        topGainersData?.append(.initMockData())
        topLosersData?.append(.initMockData())
        topTurnoverData = TopTurnoverUIModel.initMockDataArray()
        topVolumeData = TopVolumeUIModel.initMockDataArray()
        topTradesData = TopTradesUIModel.initMockDataArray()
    }
}
