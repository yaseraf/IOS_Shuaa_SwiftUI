//
//  GetBankIBANModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/10/2025.
//

import Foundation

struct GetBankIBANRequestModel: Codable {
    
}

struct GetBankIBANResponseModel: Codable {
    let accountName: String?
    let amount: String?
    let availableBalance: Double?
    let accountTo: String?
    let b2bCheques: String?
    let b2bChequesDefault: String?
    let b2bTransfer: String?
    let b2bTransferDefault: String?
    let bankAccGlNo: String?
    let bankAccNo: String?
    let bankCode: String?
    let bankName: String?
    let bankNameAlt: String?
    let branchName: String?
    let cash: Double?
    let chequeDate: String?
    let clientID: String?
    let clientIDTo: String?
    let currency: String?
    let currencyRate: String?
    let currAccBankID: String?
    let currAccCurrency: String?
    let description: String?
    let fromAccID: String?
    let iban: String?
    let investAccBankID: String?
    let isRepresentative: String?
    let isSameCurrency: String?
    let mainClientID: String?
    let payeeName: String?
    let representativeID: String?
    let requestDate: String?
    let reqApprovalStatus: String?
    let reqConfirm: String?
    let reqID: String?
    let reqType: String?
    let status: String?
    let swiftCode: String?
    let toAccID: String?
    let transferableBalance: Double?
    let transferNote: String?
    let transferNoteAr: String?
    let transferType: String?
    let userCode: String?
    let virtualAccount: String?
    let webCode: String?

    enum CodingKeys: String, CodingKey {
        case accountName = "ACCOUNT_NAME"
        case amount = "AMOUNT"
        case availableBalance = "AVILABLE_BALANCE"
        case accountTo = "AccountTo"
        case b2bCheques = "B2B_CHEQUES"
        case b2bChequesDefault = "B2B_CHEQUES_DEFAULT"
        case b2bTransfer = "B2B_TRANSFER"
        case b2bTransferDefault = "B2B_TRANSFER_DEFAULT"
        case bankAccGlNo = "BANK_ACC_GL_NO"
        case bankAccNo = "BANK_ACC_NO"
        case bankCode = "BANK_CODE"
        case bankName = "BANK_NAME"
        case bankNameAlt = "BankName"
        case branchName = "BranchName"
        case cash = "CASH"
        case chequeDate = "CHEQUE_DATE"
        case clientID = "CLIENT_ID"
        case clientIDTo = "CLIENT_ID_TO"
        case currency = "CURRENCY"
        case currencyRate = "CURRENCY_RATE"
        case currAccBankID = "CURR_ACC_BANK_ID"
        case currAccCurrency = "CURR_ACC_CURRANCY"
        case description = "DESCIPTION"
        case fromAccID = "FROM_ACC_ID"
        case iban = "IBAN"
        case investAccBankID = "INVEST_ACC_BANK_ID"
        case isRepresentative = "IS_REPRESINTITIVE"
        case isSameCurrency = "Is_Same_Currency"
        case mainClientID = "MAIN_CLIENT_ID"
        case payeeName = "PAYEE_NAME"
        case representativeID = "REPRESINTITIVE_ID"
        case requestDate = "REQUEST_DATE"
        case reqApprovalStatus = "REQ_APPROVAL_STATUS"
        case reqConfirm = "REQ_CONFIRM"
        case reqID = "REQ_ID"
        case reqType = "REQ_TYPR"
        case status = "STATUS"
        case swiftCode = "Swift_code"
        case toAccID = "TO_ACC_ID"
        case transferableBalance = "TRANSFERABLE_BALANCE"
        case transferNote = "TransferNote"
        case transferNoteAr = "TransferNoteAr"
        case transferType = "TransferType"
        case userCode = "UserCode"
        case virtualAccount = "VirtualAccount"
        case webCode = "WEB_CODE"
    }

}

struct GetBankIBANUIModel {
    var accountName: String?
    var amount: String?
    var availableBalance: Double?
    var accountTo: String?
    var b2bCheques: String?
    var b2bChequesDefault: String?
    var b2bTransfer: String?
    var b2bTransferDefault: String?
    var bankAccGlNo: String?
    var bankAccNo: String?
    var bankCode: String?
    var bankName: String?
    var bankNameAlt: String?
    var branchName: String?
    var cash: Double?
    var chequeDate: String?
    var clientID: String?
    var clientIDTo: String?
    var currency: String?
    var currencyRate: String?
    var currAccBankID: String?
    var currAccCurrency: String?
    var description: String?
    var fromAccID: String?
    var iban: String?
    var investAccBankID: String?
    var isRepresentative: String?
    var isSameCurrency: String?
    var mainClientID: String?
    var payeeName: String?
    var representativeID: String?
    var requestDate: String?
    var reqApprovalStatus: String?
    var reqConfirm: String?
    var reqID: String?
    var reqType: String?
    var status: String?
    var swiftCode: String?
    var toAccID: String?
    var transferableBalance: Double?
    var transferNote: String?
    var transferNoteAr: String?
    var transferType: String?
    var userCode: String?
    var virtualAccount: String?
    var webCode: String?

    static func mapToUIModel(_ model: GetBankIBANResponseModel) -> Self {
        return GetBankIBANUIModel(accountName: model.accountName, amount: model.amount, availableBalance: model.availableBalance, accountTo: model.accountTo, b2bCheques: model.b2bCheques, b2bChequesDefault: model.b2bChequesDefault, b2bTransfer: model.b2bTransfer, b2bTransferDefault: model.b2bTransferDefault, bankAccGlNo: model.bankAccGlNo, bankAccNo: model.bankAccNo, bankCode: model.bankCode, bankName: model.bankName, bankNameAlt: model.bankNameAlt, branchName: model.branchName, cash: model.cash, chequeDate: model.chequeDate, clientID: model.clientID, clientIDTo: model.clientIDTo, currency: model.currency, currencyRate: model.currencyRate, currAccBankID: model.currAccBankID, currAccCurrency: model.currAccCurrency, description: model.description, fromAccID: model.fromAccID, iban: model.iban, investAccBankID: model.investAccBankID, isRepresentative: model.isRepresentative, isSameCurrency: model.isSameCurrency, mainClientID: model.mainClientID, payeeName: model.payeeName, representativeID: model.representativeID, requestDate: model.requestDate, reqApprovalStatus: model.reqApprovalStatus, reqConfirm: model.reqConfirm, reqID: model.reqID, reqType: model.reqType, status: model.status, swiftCode: model.swiftCode, toAccID: model.toAccID, transferableBalance: model.transferableBalance, transferNote: model.transferNote, transferNoteAr: model.transferNoteAr, transferType: model.transferType, userCode: model.userCode, virtualAccount: model.virtualAccount, webCode: model.webCode)
    }
    
    static func initializer() -> Self {
        return GetBankIBANUIModel()
    }
}
