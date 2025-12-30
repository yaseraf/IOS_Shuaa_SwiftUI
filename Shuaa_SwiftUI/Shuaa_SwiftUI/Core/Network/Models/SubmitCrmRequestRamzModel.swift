//
//  SubmitCrmRequestRamzModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/10/2025.
//

import Foundation

struct SubmitCrmRequestRamzRequestModel: Codable {
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
}

struct SubmitCrmRequestRamzResponseModel: Codable {
    var msg: String?
    var status: String?
}

struct SubmitCrmRequestRamzUIModel {
    var msg: String?
    var status: String?

    static func mapToUIModel(_ model: SubmitCrmRequestRamzResponseModel) -> Self {
        return SubmitCrmRequestRamzUIModel(msg: model.msg, status: model.status)
    }
    
    static func initializer() -> Self {
        return SubmitCrmRequestRamzUIModel()
    }
}
