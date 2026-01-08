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
}
