//
//  IndiciesModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

struct MarketOverviewUIModel {
    var indexName: String?
    var indexValue: Double?
    var change: Double?
    var changePerc: Double?
    
    static func initializer() -> Self {
        return MarketOverviewUIModel()
    }
    
    static func initMockDataArray() -> [Self] {
        return [
            MarketOverviewUIModel(
                indexName: "General Index",
                indexValue: 9306.77,
                change: 3.36,
                changePerc: 0.036
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Real Estate Index",
                indexValue: 10417.31,
                change: 104.60,
                changePerc: 1.014
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Energy Index",
                indexValue: 2045.61,
                change: 4.43,
                changePerc: 0.217
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Consumer Staples Index",
                indexValue: 14519.92,
                change: -351.41,
                changePerc: -2.363
            ),
            MarketOverviewUIModel(
                indexName: "General Index",
                indexValue: 9306.77,
                change: 3.36,
                changePerc: 0.036
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Real Estate Index",
                indexValue: 10417.31,
                change: 104.60,
                changePerc: 1.014
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Energy Index",
                indexValue: 2045.61,
                change: 4.43,
                changePerc: 0.217
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Consumer Staples Index",
                indexValue: 14519.92,
                change: -351.41,
                changePerc: -2.363
            ),
            MarketOverviewUIModel(
                indexName: "General Index",
                indexValue: 9306.77,
                change: 3.36,
                changePerc: 0.036
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Real Estate Index",
                indexValue: 10417.31,
                change: 104.60,
                changePerc: 1.014
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Energy Index",
                indexValue: 2045.61,
                change: 4.43,
                changePerc: 0.217
            ),
            MarketOverviewUIModel(
                indexName: "FTSE ADX Consumer Staples Index",
                indexValue: 14519.92,
                change: -351.41,
                changePerc: -2.363
            )
        ]
    }
}
