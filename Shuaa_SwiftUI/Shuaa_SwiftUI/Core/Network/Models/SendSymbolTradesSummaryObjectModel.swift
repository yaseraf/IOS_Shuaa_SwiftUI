//
//  SendSymbolTradesSummaryObjectModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/09/2025.
//

import Foundation

struct SendSymbolTradesSummaryObjectResponseModel: Codable {
    var Sequence: Double?
    var Symbol: String?
    var SymbolA: String?
    var SymbolE: String?
    var Exchange: String?
    var MarketType: String?
    var Price: String?
    var Volume: String?
    var Value: Double?
    var TrdNo: Double?
    var TradeTime: String?
    var SellBuyFlag: String?
    var NetChange: String?
    var NetChgPerc: String?
    var Precision: String?
    var TradeID: String?
    var LastUpdateTime: String?
}


struct SendSymbolTradesSummaryObjectUIModel {
    var Sequence: Double?
    var Symbol: String?
    var SymbolA: String?
    var SymbolE: String?
    var Exchange: String?
    var MarketType: String?
    var Price: String?
    var Volume: String?
    var Value: Double?
    var TrdNo: Double?
    var TradeTime: String?
    var SellBuyFlag: String?
    var NetChange: String?
    var NetChgPerc: String?
    var Precision: String?
    var TradeID: String?
    var LastUpdateTime: String?
    
    static func mapToUIModel(_ model: SendSymbolTradesSummaryObjectResponseModel) -> Self {
        return SendSymbolTradesSummaryObjectUIModel(Sequence: model.Sequence, Symbol: model.Symbol, SymbolA: model.SymbolA, SymbolE: model.SymbolE, Exchange: model.Exchange, MarketType: model.MarketType, Price: model.Price, Volume: model.Volume, Value: model.Value, TrdNo: model.TrdNo, TradeTime: model.TradeTime, SellBuyFlag: model.SellBuyFlag, NetChange: model.NetChange, NetChgPerc: model.NetChgPerc, Precision: model.Precision, TradeID: model.TradeID, LastUpdateTime: model.LastUpdateTime)
    }
    
    static func initalizer() -> Self {
        return SendSymbolTradesSummaryObjectUIModel()
    }
}
