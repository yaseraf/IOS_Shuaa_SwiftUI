//
//  GetMarketWatchBySectorIDModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 15/10/2025.
//

import Foundation

struct GetMarketWatchBySectorIDRequestModel: Codable {
    let sectorID, webCode: String?

       enum CodingKeys: String, CodingKey {
           case sectorID = "SectorID"
           case webCode = "WebCode"
       }
}

struct GetMarketWatchBySectorIDResponseModel: Codable {
    let accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
        let bidVolume, buyCashFlowPerc, curCode, closePrice: String?
        let companyA, companyE, dayRange, depthBuyOrder: String?
        let depthByPrice, eps, exchange, executed: String?
        let highPrice, islm, isCryptoSymbol, isUsOnline: String?
        let indicator, isInAlerts, isInPortfolio, isMargin: String?
        let lastTradePrice, lastTradeVolume, losses, lowPrice: String?
        let marketType, maxPrice, minPrice, netChange: String?
        let netChangePerc, offerPrice, offerVolume, openPrice: String?
        let pe, pivotPoint, precision, profileID: String?
        let resistance1, resistance2, sectorA, sectorCode: String?
        let sectorE, support1, support2, symbol: String?
        let symbolCapital, symbolNameA, symbolNameArabic, symbolNameE: String?
        let symbolNameEnglish, symbolWithIcon, topPrice, totalBidExecutions: String?
        let totalBidVolume, totalOfferExecutions, totalOfferVolume, totalValue: String?
        let totalVolume, updateDateTime, webCode, recid: String?
        let wk52High, wk52Low, wk52Range: String?
    
    enum CodingKeys: String, CodingKey {
        case accumlossFlags = "AccumlossFlags"
                case allowdBuyLimit = "AllowdBuyLimit"
                case avgPrice = "AvgPrice"
                case bidPrice = "BidPrice"
                case bidVolume = "BidVolume"
                case buyCashFlowPerc = "BuyCashFlowPerc"
                case curCode = "CUR_CODE"
                case closePrice = "ClosePrice"
                case companyA = "CompanyA"
                case companyE = "CompanyE"
                case dayRange = "DayRange"
                case depthBuyOrder = "DepthBuyOrder"
                case depthByPrice = "DepthByPrice"
                case eps = "EPS"
                case exchange = "Exchange"
                case executed = "Executed"
                case highPrice = "HighPrice"
                case islm = "ISLM"
                case isCryptoSymbol = "IS_CRYPTO_SYMBOL"
                case isUsOnline = "IS_US_ONLINE"
                case indicator = "Indicator"
                case isInAlerts = "IsInAlerts"
                case isInPortfolio = "IsInPortfolio"
                case isMargin = "IsMargin"
                case lastTradePrice = "LastTradePrice"
                case lastTradeVolume = "LastTradeVolume"
                case losses = "Losses"
                case lowPrice = "LowPrice"
                case marketType = "MarketType"
                case maxPrice = "MaxPrice"
                case minPrice = "MinPrice"
                case netChange = "NetChange"
                case netChangePerc = "NetChangePerc"
                case offerPrice = "OfferPrice"
                case offerVolume = "OfferVolume"
                case openPrice = "OpenPrice"
                case pe = "PE"
                case pivotPoint = "PivotPoint"
                case precision = "Precision"
                case profileID = "ProfileID"
                case resistance1 = "Resistance1"
                case resistance2 = "Resistance2"
                case sectorA = "SectorA"
                case sectorCode = "SectorCode"
                case sectorE = "SectorE"
                case support1 = "Support1"
                case support2 = "Support2"
                case symbol = "Symbol"
                case symbolCapital = "SymbolCapital"
                case symbolNameA = "SymbolNameA"
                case symbolNameArabic = "SymbolNameArabic"
                case symbolNameE = "SymbolNameE"
                case symbolNameEnglish = "SymbolNameEnglish"
                case symbolWithIcon = "SymbolWithIcon"
                case topPrice = "TopPrice"
                case totalBidExecutions = "TotalBidExecutions"
                case totalBidVolume = "TotalBidVolume"
                case totalOfferExecutions = "TotalOfferExecutions"
                case totalOfferVolume = "TotalOfferVolume"
                case totalValue = "TotalValue"
                case totalVolume = "TotalVolume"
                case updateDateTime = "UpdateDateTime"
                case webCode = "WebCode"
                case recid, wk52High, wk52Low, wk52Range
    }
}

struct GetMarketWatchBySectorIDUIModel{
    var accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
    var bidVolume, buyCashFlowPerc, curCode, closePrice: String?
    var companyA, companyE, dayRange, depthBuyOrder: String?
    var depthByPrice, eps, exchange, executed: String?
    var highPrice, islm, isCryptoSymbol, isUsOnline: String?
    var indicator, isInAlerts, isInPortfolio, isMargin: String?
    var lastTradePrice, lastTradeVolume, losses, lowPrice: String?
    var marketType, maxPrice, minPrice, netChange: String?
    var netChangePerc, offerPrice, offerVolume, openPrice: String?
    var pe, pivotPoint, precision, profileID: String?
    var resistance1, resistance2, sectorA, sectorCode: String?
    var sectorE, support1, support2, symbol: String?
    var symbolCapital, symbolNameA, symbolNameArabic, symbolNameE: String?
    var symbolNameEnglish, symbolWithIcon, topPrice, totalBidExecutions: String?
    var totalBidVolume, totalOfferExecutions, totalOfferVolume, totalValue: String?
    var totalVolume, updateDateTime, webCode, recid: String?
    var wk52High, wk52Low, wk52Range: String?
    
    static func mapToUIModel(_ m:GetMarketWatchBySectorIDResponseModel)->Self {
        return  GetMarketWatchBySectorIDUIModel(accumlossFlags: m.accumlossFlags, allowdBuyLimit: m.allowdBuyLimit, avgPrice: m.avgPrice, bidPrice: m.bidPrice, bidVolume: m.bidVolume, buyCashFlowPerc: m.buyCashFlowPerc, curCode: m.curCode, closePrice: m.closePrice, companyA: m.companyA, companyE: m.companyE, dayRange: m.dayRange, depthBuyOrder: m.depthBuyOrder, depthByPrice: m.depthByPrice, eps: m.eps, exchange: m.exchange, executed: m.executed, highPrice: m.highPrice, islm: m.islm, isCryptoSymbol: m.isCryptoSymbol, isUsOnline: m.isUsOnline, indicator: m.indicator, isInAlerts: m.isInAlerts, isInPortfolio: m.isInPortfolio, isMargin: m.isMargin, lastTradePrice: m.lastTradePrice, lastTradeVolume: m.lastTradeVolume, losses: m.losses, lowPrice: m.lowPrice, marketType: m.marketType, maxPrice: m.maxPrice, minPrice: m.minPrice, netChange: m.netChange, netChangePerc: m.netChangePerc, offerPrice: m.offerPrice, offerVolume: m.offerVolume, openPrice: m.openPrice, pe: m.pe, pivotPoint: m.pivotPoint, precision: m.precision, profileID: m.profileID, resistance1: m.resistance1, resistance2: m.resistance2, sectorA: m.sectorA, sectorCode: m.sectorCode, sectorE: m.sectorE, support1: m.support1, support2: m.support2, symbol: m.symbol, symbolCapital: m.symbolCapital, symbolNameA: m.symbolNameA, symbolNameArabic: m.symbolNameArabic, symbolNameE: m.symbolNameE, symbolNameEnglish: m.symbolNameEnglish, symbolWithIcon: m.symbolWithIcon, topPrice: m.topPrice, totalBidExecutions: m.totalBidExecutions, totalBidVolume: m.totalBidVolume, totalOfferExecutions: m.totalOfferExecutions, totalOfferVolume: m.totalOfferVolume, totalValue: m.totalValue, totalVolume: m.totalVolume, updateDateTime: m.updateDateTime, webCode: m.webCode, recid: m.recid, wk52High: m.wk52High, wk52Low: m.wk52Low, wk52Range: m.wk52Range)
    }
    
    static func initializer() -> Self {
        return GetMarketWatchBySectorIDUIModel()
    }
}
