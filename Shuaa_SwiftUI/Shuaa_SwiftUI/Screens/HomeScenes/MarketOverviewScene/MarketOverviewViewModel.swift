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
        var data: [MarketsUIModel] = []
        
        data.append(MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .MMMdd_yyyy_at_WithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254"))
        
        marketsData = data
    }

    func getMarketOverviewData() {
        var data: [MarketOverviewUIModel] = []
    
        data.append(MarketOverviewUIModel(indexName: "General Index", indexValue: 9306.77, change: 3.36, changePerc: 0.036))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Real Estate Index", indexValue: 10417.31, change: 104.60, changePerc: 1.014))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Energy Index", indexValue: 2045.61, change: 4.43, changePerc: 0.217))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Consumer Staples Index", indexValue: 14519.92, change: -351.41, changePerc: -2.363))
        data.append(MarketOverviewUIModel(indexName: "General Index", indexValue: 9306.77, change: 3.36, changePerc: 0.036))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Real Estate Index", indexValue: 10417.31, change: 104.60, changePerc: 1.014))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Energy Index", indexValue: 2045.61, change: 4.43, changePerc: 0.217))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Consumer Staples Index", indexValue: 14519.92, change: -351.41, changePerc: -2.363))
        data.append(MarketOverviewUIModel(indexName: "General Index", indexValue: 9306.77, change: 3.36, changePerc: 0.036))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Real Estate Index", indexValue: 10417.31, change: 104.60, changePerc: 1.014))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Energy Index", indexValue: 2045.61, change: 4.43, changePerc: 0.217))
        data.append(MarketOverviewUIModel(indexName: "FTSE ADX Consumer Staples Index", indexValue: 14519.92, change: -351.41, changePerc: -2.363))
        
        indicesData = data
    }
}
