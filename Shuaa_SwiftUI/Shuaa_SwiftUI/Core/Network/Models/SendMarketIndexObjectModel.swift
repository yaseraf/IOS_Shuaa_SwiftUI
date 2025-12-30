//
//  SendMarketIndexObjectModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/10/2025.
//

import Foundation

struct SendMarketIndexObjectResponseModel: Codable {
    let exchangeID: String?
    let nameE: String?
    let nameA: String?
    let currentValue: String?
    let previousValue: String?
    let netChange: String?
    let netChangePerc: String?
    let high: String?
    let low: String?
    let sector: String?
    let turnOver: String?
    let volume: String?
    let totalTrades: String?
    let isinCode: String?
    let nameShort: String?
    let isDelayed: String?
    let lastUpdateTime: Date?
    let lastTradeTime: Date?

    enum CodingKeys: String, CodingKey {
        case exchangeID = "ExchangeID"
        case nameE = "NameE"
        case nameA = "NameA"
        case currentValue = "CurrentValue"
        case previousValue = "PreviousValue"
        case netChange = "NetChange"
        case netChangePerc = "NetChangePerc"
        case high = "High"
        case low = "Low"
        case sector = "Sector"
        case turnOver = "TurnOver"
        case volume = "Volume"
        case totalTrades = "TotalTrades"
        case isinCode = "ISIN_Code"
        case nameShort = "NAME_SHORT"
        case isDelayed = "IsDelayed"
        case lastUpdateTime = "LastUpdateTime"
        case lastTradeTime = "LastTradeTime"
    }
}

struct SendMarketIndexObjectUIModel {
    let exchangeID: String?
    let nameE: String?
    let nameA: String?
    let currentValue: String?
    let previousValue: String?
    let netChange: String?
    let netChangePerc: String?
    let high: String?
    let low: String?
    let sector: String?
    let turnOver: String?
    let volume: String?
    let totalTrades: String?
    let isinCode: String?
    let nameShort: String?
    let isDelayed: String?
    let lastUpdateTime: Date?
    let lastTradeTime: Date?
    
    static func mapToUIModel(_ model: SendMarketIndexObjectResponseModel) -> Self {
        return SendMarketIndexObjectUIModel(exchangeID: model.exchangeID, nameE: model.nameE, nameA: model.nameA, currentValue: model.currentValue, previousValue: model.previousValue, netChange: model.netChange, netChangePerc: model.netChangePerc, high: model.high, low: model.low, sector: model.sector, turnOver: model.turnOver, volume: model.volume, totalTrades: model.totalTrades, isinCode: model.isinCode, nameShort: model.nameShort, isDelayed: model.isDelayed, lastUpdateTime: model.lastUpdateTime, lastTradeTime: model.lastTradeTime)
    }
}
