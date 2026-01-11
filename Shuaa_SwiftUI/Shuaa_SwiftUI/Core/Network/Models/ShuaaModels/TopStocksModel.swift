//
//  TopStocksModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

protocol TopStocksModel {
}

struct TopGainersUIModel: TopStocksModel {
    var symbol: String?
    var price: Double?
    var volume: Double?
    var change: Double?
    var changePercent: Double?
    
    static func initializer() -> Self {
        return TopGainersUIModel()
    }
    
    static func initMockData() -> Self {
        return TopGainersUIModel(
            symbol: "ETISALAT",
            price: 36.68,
            volume: 485395,
            change: 0.1,
            changePercent: 10
        )
    }
}

struct TopLosersUIModel: TopStocksModel {
    var symbol: String?
    var price: Double?
    var volume: Double?
    var change: Double?
    var changePercent: Double?
    
    static func initializer() -> Self {
        return TopLosersUIModel()
    }
    
    static func initMockData() -> Self {
        return TopLosersUIModel(
            symbol: "WATANIA",
            price: 0.65,
            volume: 29500,
            change: -0.004,
            changePercent: -0.62
        )
    }
}

struct TopTurnoverUIModel: TopStocksModel {
    var symbol: String?
    var price: Double?
    var turnover: Double?
    var trades: Double?
    var changePercent: Double?
    
    static func initializer() -> Self {
        return TopTurnoverUIModel()
    }
    
    static func initMockData() -> Self {
        return TopTurnoverUIModel(
            symbol: "ETISALAT",
            price: 36.68,
            turnover: 17796572.12,
            trades: 250,
            changePercent: 10
        )
    }
    
    static func initMockDataArray() -> [Self] {
        return [
            TopTurnoverUIModel(
                symbol: "ETISALAT",
                price: 36.68,
                turnover: 17796572.12,
                trades: 250,
                changePercent: 10
            ),
            TopTurnoverUIModel(
                symbol: "WATANIA",
                price: 0.65,
                turnover: 19166,
                trades: 4,
                changePercent: -0.62
            )
        ]
    }
}

struct TopVolumeUIModel: TopStocksModel {
    var symbol: String?
    var price: Double?
    var turnover: Double?
    var volume: Double?
    var changePercent: Double?
    
    static func initializer() -> Self {
        return TopVolumeUIModel()
    }
    
    static func initMockData() -> Self {
        return TopVolumeUIModel(
            symbol: "WATANIA",
            price: 0.65,
            turnover: 19166,
            volume: 29500,
            changePercent: -0.62
        )
    }
    
    static func initMockDataArray() -> [Self] {
        return [
            TopVolumeUIModel(
                symbol: "ETISALAT",
                price: 36.68,
                turnover: 17796572.12,
                volume: 485395,
                changePercent: 10
            ),
            TopVolumeUIModel(
                symbol: "WATANIA",
                price: 0.65,
                turnover: 19166,
                volume: 29500,
                changePercent: -0.62
            )
        ]
    }
}

struct TopTradesUIModel: TopStocksModel {
    var symbol: String?
    var price: Double?
    var turnover: Double?
    var trades: Double?
    var changePercent: Double?
    
    static func initializer() -> Self {
        return TopTradesUIModel()
    }
    
    static func initMockData() -> Self {
        return TopTradesUIModel(
            symbol: "ETISALAT",
            price: 36.68,
            turnover: 17796572.12,
            trades: 250,
            changePercent: 10
        )
    }
    
    static func initMockDataArray() -> [Self] {
        return [
            TopTradesUIModel(
                symbol: "ETISALAT",
                price: 36.68,
                turnover: 17796572.12,
                trades: 250,
                changePercent: 10
            ),
            TopTradesUIModel(
                symbol: "WATANIA",
                price: 0.65,
                turnover: 19166,
                trades: 4,
                changePercent: -0.62
            )
        ]
    }
}
