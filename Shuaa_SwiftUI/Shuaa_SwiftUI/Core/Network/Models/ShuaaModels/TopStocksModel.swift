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
}
