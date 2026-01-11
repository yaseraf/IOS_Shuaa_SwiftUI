//
//  StocksModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 31/12/2025.
//

import Foundation

struct StocksUIModel {
    var stockName: String?
    var lastTradePrice: Double?
    var netChange: Double?
    var netChangePerc: Double?
    
    static func initializer() -> Self {
        return StocksUIModel()
    }
}
