//
//  GetSymbolTradesFullObjectModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/09/2025.
//

import Foundation

struct GetSymbolTradesFullObjectResponseModel: Codable {
    var symbol, exchange, marketType: String?
    var symbolA, symbolE: String?
    var price, volume: String?
    var value, trdNo: Double?
    var sellBuyFlag, tradeTime: String?
    var netChange, netChgPerc, precision, lastUpdateTime: String?
    var Sequence: Double?
    var priceColor :String?
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case symbolA = "SymbolA"
        case symbolE = "SymbolE"
        case exchange = "Exchange"
        case marketType = "MarketType"
        case price = "Price"
        case volume = "Volume"
        case value = "Value"
        case trdNo = "TrdNo"
        case tradeTime = "TradeTime"
        case sellBuyFlag = "SellBuyFlag"
        case netChange = "NetChange"
        case netChgPerc = "NetChgPerc"
        case precision = "Precision"
        case lastUpdateTime = "LastUpdateTime"
        case Sequence = "Sequence"
    }

}

struct GetSymbolTradesFullObjectUIModel {
    var symbol, exchange, marketType: String?
    var symbolA, symbolE: String?
    var price, volume: String?
    var value, trdNo: Double?
    var sellBuyFlag, tradeTime: String?
    var netChange, netChgPerc, precision, lastUpdateTime: String?
    var Sequence: Double?
    var priceColor :String?

    static func mapToUIModel(_ model: GetSymbolTradesFullObjectResponseModel) -> Self {
        return GetSymbolTradesFullObjectUIModel(symbol: model.symbol, exchange: model.exchange, marketType: model.marketType, symbolA: model.symbolA, symbolE: model.symbolE, price: model.price, volume: model.volume, value: model.value, trdNo: model.trdNo, sellBuyFlag: model.sellBuyFlag, tradeTime: model.tradeTime, netChange: model.netChange, netChgPerc: model.netChgPerc, precision: model.precision, lastUpdateTime: model.lastUpdateTime, Sequence: model.Sequence, priceColor: model.priceColor)
    }
    
    static func initializer() -> Self {
        return GetSymbolTradesFullObjectUIModel()
    }
}
