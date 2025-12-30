//
//  GetMarketTimeSaleModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/09/2025.
//

import Foundation

struct GetMarketTimeSaleResponseModel: Codable {
    var Symbol, Exchange, MarketType, Price, Volume, TradeTime: String?
    var SymbolA, SymbolE,symbolID, NetChgPerc: String?
    var SellBuyFlag: String?
    var NetChange, Precision, LastUpdateTime : String?
    var Value: Double? = 0.0
    var TrdNo: Double? = 0
    var Sequence: Double? = 0
    
    enum CodingKeys: String, CodingKey {
        case Symbol = "Symbol"
        case SymbolA = "SymbolA"
        case SymbolE = "SymbolE"
        case symbolID = "symbolID"
        case Exchange = "Exchange"
        case MarketType = "MarketType"
        case Price = "Price"
        case Volume = "Volume"
        case TradeTime = "TradeTime"
        case SellBuyFlag = "SellBuyFlag"
        case NetChange = "NetChange"
        case NetChgPerc = "NetChgPerc"
        case Precision = "Precision"
        case LastUpdateTime = "LastUpdateTime"
        case Value = "Value"
        case TrdNo = "TrdNo"
        case Sequence = "Sequence"
    }

}

struct GetMarketTimeSaleUIModel {
    var Symbol, Exchange, MarketType, Price, Volume, TradeTime: String?
    var SymbolA, SymbolE,symbolID, NetChgPerc: String?
    var SellBuyFlag: String?
    var NetChange, Precision, LastUpdateTime : String?
    var Value: Double? = 0.0
    var TrdNo: Double? = 0
    var Sequence: Double? = 0

    static func mapToUIModel(_ model: GetMarketTimeSaleResponseModel) -> Self {
        return GetMarketTimeSaleUIModel(Symbol: model.Symbol, Exchange: model.Exchange, MarketType: model.MarketType, Price: model.Price, Volume: model.Volume, TradeTime: model.TradeTime, SymbolA: model.SymbolA, SymbolE: model.SymbolE, symbolID: model.symbolID, NetChgPerc: model.NetChgPerc, SellBuyFlag: model.SellBuyFlag, NetChange: model.NetChange, Precision: model.Precision, LastUpdateTime: model.LastUpdateTime, Value: model.Value, TrdNo: model.TrdNo, Sequence: model.Sequence)
    }
    
    static func initializer() -> Self {
        return GetMarketTimeSaleUIModel()
    }
}
