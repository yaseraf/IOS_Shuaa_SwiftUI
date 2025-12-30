//
//  GetPortfolioSignalRModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/09/2025.
//

import Foundation

struct GetPortfolioSignalRResponseModel: Codable {
    var companyShortA, companyShortE, custodianA, custodianE: String?
    var clientID, companyNameA, companyNameE, curCode: String?
    var currDiff: Double?
    var custodianID: String?
    var ePrice: Double?
    var exchange: String?
    var locBookedPSValue, locNValue, nValue, pCost: Double?
    var pPerc, pProf, prClosePrice: Double?
    var prPriceDate, precision: String?
    var profit, psValue: Double?
    var qtySettled, qtyT0, qtyT1, qtyT2: Int?
    var qtyUnsettled, qty: Int?
    var rate: Double?
    var realized_Today: String? = "0"
    var sectorA, sectorE, symbol: String?
    var totalExpectedProfitLoss, totalExpectedSellComm, totalNetProfitLoss, totalRealizedProfitLoss: Double?
    var typeA, typeE: String?
    var totalCostValue:Double = 0.0
    var percHolding: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case companyShortA = "COMPANY_SHORT_A"
        case companyShortE = "COMPANY_SHORT_E"
        case custodianA = "CUSTODIAN_A"
        case custodianE = "CUSTODIAN_E"
        case clientID = "ClientID"
        case companyNameA = "CompanyNameA"
        case companyNameE = "CompanyNameE"
        case curCode = "CurCode"
        case currDiff = "CurrDiff"
        case custodianID = "CustodianId"
        case ePrice = "EPrice"
        case exchange = "Exchange"
        case locBookedPSValue = "LocBookedPsValue"
        case locNValue = "LocNValue"
        case nValue = "NValue"
        case pCost = "PCost"
        case pPerc = "PPerc"
        case pProf = "PProf"
        case prClosePrice = "PrClosePrice"
        case prPriceDate = "PrPriceDate"
        case precision = "Precision"
        case profit = "Profit"
        case psValue = "PsValue"
        case qtySettled = "QTY_SETTLED"
        case qtyT0 = "QTY_T0"
        case qtyT1 = "QTY_T1"
        case qtyT2 = "QTY_T2"
        case qtyUnsettled = "QTY_UNSETTLED"
        case qty = "Qty"
        case rate = "Rate"
        case realized_Today = "Realized_Today"
        case sectorA = "SectorA"
        case sectorE = "SectorE"
        case symbol = "Symbol"
        case totalExpectedProfitLoss = "Total_Expected_Profit_Loss"
        case totalExpectedSellComm = "Total_Expected_Sell_Comm"
        case totalNetProfitLoss = "Total_Net_Profit_Loss"
        case totalRealizedProfitLoss = "Total_Realized_Profit_Loss"
        case typeA = "TypeA"
        case typeE = "TypeE"
    }
}

struct GetPortfolioSignalRUIModel {
    var companyShortA, companyShortE, custodianA, custodianE: String?
    var clientID, companyNameA, companyNameE, curCode: String?
    var currDiff: Double?
    var custodianID: String?
    var ePrice: Double?
    var exchange: String?
    var locBookedPSValue, locNValue, nValue, pCost: Double?
    var pPerc, pProf, prClosePrice: Double?
    var prPriceDate, precision: String?
    var profit, psValue: Double?
    var qtySettled, qtyT0, qtyT1, qtyT2: Int?
    var qtyUnsettled, qty: Int?
    var rate: Double?
    var realized_Today: String? = "0"
    var sectorA, sectorE, symbol: String?
    var totalExpectedProfitLoss, totalExpectedSellComm, totalNetProfitLoss, totalRealizedProfitLoss: Double?
    var typeA, typeE: String?
    var totalCostValue:Double = 0.0
    var percHolding: Double = 0.0

    static func mapToUIModel(_ model: GetPortfolioSignalRResponseModel) -> Self {
        return GetPortfolioSignalRUIModel(companyShortA: model.companyNameA, companyShortE: model.companyNameE, custodianA: model.custodianA, custodianE: model.custodianE, clientID: model.clientID, companyNameA: model.companyNameA, companyNameE: model.companyNameE, curCode: model.curCode, currDiff: model.currDiff, custodianID: model.custodianID, ePrice: model.ePrice, exchange: model.exchange, locBookedPSValue: model.locBookedPSValue, locNValue: model.locNValue, nValue: model.nValue, pCost: model.pCost, pPerc: model.pPerc, pProf: model.pProf, prClosePrice: model.prClosePrice, prPriceDate: model.prPriceDate, precision: model.precision, profit: model.profit, psValue: model.psValue, qtySettled: model.qtySettled, qtyT0: model.qtyT0, qtyT1: model.qtyT1, qtyT2: model.qtyT2, qtyUnsettled: model.qtyUnsettled, qty: model.qty, rate: model.rate, realized_Today: model.realized_Today, sectorA: model.sectorA, sectorE: model.sectorE, symbol: model.symbol, totalExpectedProfitLoss: model.totalExpectedProfitLoss, totalExpectedSellComm: model.totalExpectedSellComm, totalNetProfitLoss: model.totalNetProfitLoss, totalRealizedProfitLoss: model.totalRealizedProfitLoss, typeA: model.typeA, typeE: model.typeE, totalCostValue: model.totalCostValue, percHolding: model.percHolding)
    }
    
    static func initializer() -> Self {
        return GetPortfolioSignalRUIModel()
    }
}
