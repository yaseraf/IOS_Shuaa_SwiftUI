//
//  GetAccountTransferInfoModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/10/2025.
//

import Foundation

struct GetAccountTransferInfoRequestModel: Codable {
    let ACCOUNT_NAME: String?
    let AMOUNT: String?
    let AVILABLE_BALANCE: Double?
    let AccountTo: String?
    let B2B_CHEQUES: String?
    let B2B_CHEQUES_DEFAULT: String?
    let B2B_TRANSFER: String?
    let B2B_TRANSFER_DEFAULT: String?
    let BANK_ACC_GL_NO: String?
    let BANK_ACC_NO: String?
    let BANK_CODE: String?
    let BANK_NAME: String?
    let BankName: String?
    let BranchName: String?
    let CASH: Double?
    let CHEQUE_DATE: String?
    let CLIENT_ID: String?
    let CLIENT_ID_TO: String?
    let CURRENCY: String?
    let CURRENCY_RATE: String?
    let CURR_ACC_BANK_ID: String?
    let CURR_ACC_CURRANCY: String?
    let DESCIPTION: String?
    let FROM_ACC_ID: String?
    let IBAN: String?
    let INVEST_ACC_BANK_ID: String?
    let IS_REPRESINTITIVE: String?
    let Is_Same_Currency: String?
    let MAIN_CLIENT_ID: String?
    let PAYEE_NAME: String?
    let REPRESINTITIVE_ID: String?
    let REQUEST_DATE: String?
    let REQ_APPROVAL_STATUS: String?
    let REQ_CONFIRM: String?
    let REQ_ID: String?
    let REQ_TYPR: String?
    let STATUS: String?
    let Swift_code: String?
    let TO_ACC_ID: String?
    let TRANSFERABLE_BALANCE: Double?
    let TransferNote: String?
    let TransferNoteAr: String?
    let TransferType: String?
    let UserCode: String?
    let VirtualAccount: String?
    let WEB_CODE: String?
}


struct GetAccountTransferInfoResponseModel: Codable {
    let ACCOUNT_NAME: String?
    let AMOUNT: String?
    let AVILABLE_BALANCE: Double?
    let AccountTo: String?
    let B2B_CHEQUES: String?
    let B2B_CHEQUES_DEFAULT: String?
    let B2B_TRANSFER: String?
    let B2B_TRANSFER_DEFAULT: String?
    let BANK_ACC_GL_NO: String?
    let BANK_ACC_NO: String?
    let BANK_CODE: String?
    let BANK_NAME: String?
    let BankName: String?
    let BranchName: String?
    let CASH: Double?
    let CHEQUE_DATE: String?
    let CLIENT_ID: String?
    let CLIENT_ID_TO: String?
    let CURRENCY: String?
    let CURRENCY_RATE: String?
    let CURR_ACC_BANK_ID: String?
    let CURR_ACC_CURRANCY: String?
    let DESCIPTION: String?
    let FROM_ACC_ID: String?
    let IBAN: String?
    let INVEST_ACC_BANK_ID: String?
    let IS_REPRESINTITIVE: String?
    let Is_Same_Currency: String?
    let MAIN_CLIENT_ID: String?
    let PAYEE_NAME: String?
    let REPRESINTITIVE_ID: String?
    let REQUEST_DATE: String?
    let REQ_APPROVAL_STATUS: String?
    let REQ_CONFIRM: String?
    let REQ_ID: String?
    let REQ_TYPR: String?
    let STATUS: String?
    let Swift_code: String?
    let TO_ACC_ID: String?
    let TRANSFERABLE_BALANCE: Double?
    let TransferNote: String?
    let TransferNoteAr: String?
    let TransferType: String?
    let UserCode: String?
    let VirtualAccount: String?
    let WEB_CODE: String?
}

struct GetAccountTransferInfoUIModel {
    var ACCOUNT_NAME: String?
    var AMOUNT: String?
    var AVILABLE_BALANCE: Double?
    var AccountTo: String?
    var B2B_CHEQUES: String?
    var B2B_CHEQUES_DEFAULT: String?
    var B2B_TRANSFER: String?
    var B2B_TRANSFER_DEFAULT: String?
    var BANK_ACC_GL_NO: String?
    var BANK_ACC_NO: String?
    var BANK_CODE: String?
    var BANK_NAME: String?
    var BankName: String?
    var BranchName: String?
    var CASH: Double?
    var CHEQUE_DATE: String?
    var CLIENT_ID: String?
    var CLIENT_ID_TO: String?
    var CURRENCY: String?
    var CURRENCY_RATE: String?
    var CURR_ACC_BANK_ID: String?
    var CURR_ACC_CURRANCY: String?
    var DESCIPTION: String?
    var FROM_ACC_ID: String?
    var IBAN: String?
    var INVEST_ACC_BANK_ID: String?
    var IS_REPRESINTITIVE: String?
    var Is_Same_Currency: String?
    var MAIN_CLIENT_ID: String?
    var PAYEE_NAME: String?
    var REPRESINTITIVE_ID: String?
    var REQUEST_DATE: String?
    var REQ_APPROVAL_STATUS: String?
    var REQ_CONFIRM: String?
    var REQ_ID: String?
    var REQ_TYPR: String?
    var STATUS: String?
    var Swift_code: String?
    var TO_ACC_ID: String?
    var TRANSFERABLE_BALANCE: Double?
    var TransferNote: String?
    var TransferNoteAr: String?
    var TransferType: String?
    var UserCode: String?
    var VirtualAccount: String?
    var WEB_CODE: String?
    
    static func mapToUIModel(_ model: GetAccountTransferInfoResponseModel) -> Self {
        return GetAccountTransferInfoUIModel(ACCOUNT_NAME: model.ACCOUNT_NAME, AMOUNT: model.AMOUNT, AVILABLE_BALANCE: model.AVILABLE_BALANCE, AccountTo: model.AccountTo, B2B_CHEQUES: model.B2B_CHEQUES, B2B_CHEQUES_DEFAULT: model.B2B_CHEQUES_DEFAULT, B2B_TRANSFER: model.B2B_TRANSFER, B2B_TRANSFER_DEFAULT: model.B2B_TRANSFER_DEFAULT, BANK_ACC_GL_NO: model.BANK_ACC_GL_NO, BANK_ACC_NO: model.BANK_ACC_NO, BANK_CODE: model.BANK_CODE, BANK_NAME: model.BANK_NAME, BankName: model.BankName, BranchName: model.BranchName, CASH: model.CASH, CHEQUE_DATE: model.CHEQUE_DATE, CLIENT_ID: model.CLIENT_ID, CLIENT_ID_TO: model.CLIENT_ID_TO, CURRENCY: model.CURRENCY, CURRENCY_RATE: model.CURRENCY_RATE, CURR_ACC_BANK_ID: model.CURR_ACC_BANK_ID, CURR_ACC_CURRANCY: model.CURR_ACC_CURRANCY, DESCIPTION: model.DESCIPTION, FROM_ACC_ID: model.FROM_ACC_ID, IBAN: model.IBAN, INVEST_ACC_BANK_ID: model.INVEST_ACC_BANK_ID, IS_REPRESINTITIVE: model.IS_REPRESINTITIVE, Is_Same_Currency: model.Is_Same_Currency, MAIN_CLIENT_ID: model.MAIN_CLIENT_ID, PAYEE_NAME: model.PAYEE_NAME, REPRESINTITIVE_ID: model.REPRESINTITIVE_ID, REQUEST_DATE: model.REQUEST_DATE, REQ_APPROVAL_STATUS: model.REQ_APPROVAL_STATUS, REQ_CONFIRM: model.REQ_CONFIRM, REQ_ID: model.REQ_ID, REQ_TYPR: model.REQ_TYPR, STATUS: model.STATUS, Swift_code: model.Swift_code, TO_ACC_ID: model.TO_ACC_ID, TRANSFERABLE_BALANCE: model.TRANSFERABLE_BALANCE, TransferNote: model.TransferNote, TransferNoteAr: model.TransferNoteAr, TransferType: model.TransferType, UserCode: model.UserCode, VirtualAccount: model.VirtualAccount, WEB_CODE: model.WEB_CODE)
    }
    
    static func initializer() -> Self {
        return GetAccountTransferInfoUIModel()
    }
}
