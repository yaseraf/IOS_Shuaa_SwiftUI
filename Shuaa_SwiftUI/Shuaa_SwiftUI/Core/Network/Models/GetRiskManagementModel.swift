//
//  GetRiskManagementModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 01/10/2025.
//

import Foundation

struct GetRiskManagementRequestModel: Codable {
    
}

struct GetRiskManagementResponseModel: Codable {
    var accountID, approvalType, availBAL, bank: String?
    var bankAccountNo, buyOrders, buyPower, buyTrades: String?
    var clientNameA, clientNameE, cash, clientID: String?
    var facilitiesAmt: String?
    var flag, flagMsgA, flagMsgE: String?
    var msValidation, marginAmnt, memberID, nin: String?
    var offLineOrderDate, orderValue, sellOrders, sellTrades: String?
    var shares, unpostedCRTrxns, unpostedDBTrxns, brokerID: String?

    enum CodingKeys: String, CodingKey {
        case accountID = "AccountID"
        case approvalType = "Approval_Type"
        case availBAL = "AvailBal"
        case bank = "BANK"
        case bankAccountNo = "BANK_ACCOUNT_NO"
        case buyOrders = "BuyOrders"
        case buyPower = "BuyPower"
        case buyTrades = "BuyTrades"
        case clientNameA = "CLIENT_NAME_A"
        case clientNameE = "CLIENT_NAME_E"
        case cash = "Cash"
        case clientID = "ClientID"
        case facilitiesAmt = "FacilitiesAmt"
        case flag = "Flag"
        case flagMsgA = "FlagMsgA"
        case flagMsgE = "FlagMsgE"
        case msValidation = "MSValidation"
        case marginAmnt = "MarginAmnt"
        case memberID = "MemberID"
        case nin = "NIN"
        case offLineOrderDate = "OffLineOrderDate"
        case orderValue = "OrderValue"
        case sellOrders = "SellOrders"
        case sellTrades = "SellTrades"
        case shares = "Shares"
        case unpostedCRTrxns = "UnpostedCRTrxns"
        case unpostedDBTrxns = "UnpostedDBTrxns"
        case brokerID = "broker_ID"
    }
}

struct GetRiskManagementUIModel {
    var accountID, approvalType, availBAL, bank: String?
    var bankAccountNo, buyOrders, buyPower, buyTrades: String?
    var clientNameA, clientNameE, cash, clientID: String?
    var facilitiesAmt: String?
    var flag, flagMsgA, flagMsgE: String?
    var msValidation, marginAmnt, memberID, nin: String?
    var offLineOrderDate, orderValue, sellOrders, sellTrades: String?
    var shares, unpostedCRTrxns, unpostedDBTrxns, brokerID: String?
    
    static func mapToUIModel(_ model: GetRiskManagementResponseModel) -> Self {
        return GetRiskManagementUIModel(accountID: model.accountID, approvalType: model.approvalType, availBAL: model.availBAL, bank: model.bank, bankAccountNo: model.bankAccountNo, buyOrders: model.buyOrders, buyPower: model.buyPower, buyTrades: model.buyTrades, clientNameA: model.clientNameA, clientNameE: model.clientNameE, cash: model.cash, clientID: model.clientID, facilitiesAmt: model.facilitiesAmt, flag: model.flag, flagMsgA: model.flagMsgA, flagMsgE: model.flagMsgE, msValidation: model.msValidation, marginAmnt: model.marginAmnt, memberID: model.memberID, nin: model.nin, offLineOrderDate: model.offLineOrderDate, orderValue: model.orderValue, sellOrders: model.sellOrders, sellTrades: model.sellTrades, shares: model.shares, unpostedCRTrxns: model.unpostedCRTrxns, unpostedDBTrxns: model.unpostedDBTrxns, brokerID: model.brokerID)
    }
    
    static func initializer() -> Self {
        return GetRiskManagementUIModel()
    }
}
