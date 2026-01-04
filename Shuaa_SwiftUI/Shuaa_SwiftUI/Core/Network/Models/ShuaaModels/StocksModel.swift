//
//  StocksModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 31/12/2025.
//

import Foundation

struct StocksUIModel {
    var stockName: String?
    var lastTradePrice: String?
    var netChange: String?
    var netChangePerc: String?
    
    static func initializer() -> Self {
        return StocksUIModel()
    }
}
