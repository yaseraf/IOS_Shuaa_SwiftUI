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
    var lastTradePrice: String?
    var netChange: String?
    var netChangePerc: String?
    var symbolsTraded: String?
    var tradesUp: String?
    var tradesEqual: String?
    var tradesDown: String?
    var turnover: String?
    var volume: String?
    var trades: String?
    
    static func initializer() -> Self {
        return MarketsUIModel()
    }
}
