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
        var data: [MarketsUIModel] = []
        
        data.append(MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .MMMdd_yyyy_at_WithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254"))
        
        marketsData = data
    }

    func getTopStocksData() {
        var gainersData: [TopGainersUIModel] = []
        gainersData.append(TopGainersUIModel(symbol: "ETISALAT", price: 36.68, volume: 485395, change: 0.1, changePercent: 10))
        topGainersData = gainersData
        
        var losersData: [TopLosersUIModel] = []
        losersData.append(TopLosersUIModel(symbol: "WATANIA", price: 0.65, volume: 29500, change: -0.004, changePercent: -0.62))
        topLosersData = losersData

        var turnoverData: [TopTurnoverUIModel] = []
        turnoverData.append(TopTurnoverUIModel(symbol: "ETISALAT", price: 36.68, turnover: 17796572.12, trades: 250, changePercent: 10))
        turnoverData.append(TopTurnoverUIModel(symbol: "WATANIA", price: 0.65, turnover: 19166, trades: 4, changePercent: -0.62))
        topTurnoverData = turnoverData

        var volumeData: [TopVolumeUIModel] = []
        volumeData.append(TopVolumeUIModel(symbol: "ETISALAT", price: 36.68, turnover: 17796572.12, volume: 485395, changePercent: 10))
        volumeData.append(TopVolumeUIModel(symbol: "WATANIA", price: 0.65, turnover: 19166, volume: 29500, changePercent: -0.62))
        topVolumeData = volumeData

        var tradesData: [TopTradesUIModel] = []
        tradesData.append(TopTradesUIModel(symbol: "ETISALAT", price: 36.68, turnover: 17796572.12, trades: 250, changePercent: 10))
        tradesData.append(TopTradesUIModel(symbol: "WATANIA", price: 0.65, turnover: 19166, trades: 4, changePercent: -0.62))
        topTradesData = tradesData

    }
}
