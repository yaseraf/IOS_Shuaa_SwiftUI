//
//  BanksModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 31/12/2025.
//

import Foundation

struct MarketsUIModel {
    var marketName: String?
    var marketStatus: String?
    var marketDate: String?
    var lastTradePrice: Double?
    var netChange: Double?
    var netChangePerc: Double?
    var symbolsTraded: Double?
    var tradesUp: Double?
    var tradesEqual: Double?
    var tradesDown: Double?
    var turnover: Double?
    var volume: Double?
    var trades: Double?
    
    static func initializer() -> Self {
        return MarketsUIModel()
    }
    
    static func initMockData() -> Self {
        return MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .yyMMddWithTime), lastTradePrice: 9306.77, netChange: 3.36, netChangePerc: 0.04, symbolsTraded: 2, tradesUp: 1, tradesEqual: 0, tradesDown: 1, turnover: 17815738, volume: 514895, trades: 254)
    }
}

