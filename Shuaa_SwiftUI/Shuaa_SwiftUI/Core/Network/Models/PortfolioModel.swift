//
//  PortfolioModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 13/01/2026.
//

import Foundation

struct PortfolioUIModel {
    var symbol: String?
    var quantity: Double?
    var closePrice: Double?
    var marketValue: Double?
    var averageCost: Double?
    var costValue: Double?
    var unrealizePnL: Double?
    var realisedPnL: Double?
    var percPnL: Double?
    var percHolding: Double?
    
    static func initializer() -> Self {
        return PortfolioUIModel()
    }
    
    static func initMockData() -> Self {
        return PortfolioUIModel(symbol: "", quantity: 0, closePrice: 0, marketValue: 0, averageCost: 0, costValue: 0, unrealizePnL: 0, realisedPnL: 0, percPnL: 0, percHolding: 0)
    }

}
