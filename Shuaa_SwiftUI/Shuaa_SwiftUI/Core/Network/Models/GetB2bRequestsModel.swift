//
//  GetB2bRequestsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 08/12/2025.
//

import Foundation

struct GetB2bRequestsRequestModel: Codable {
    
}

struct GetB2bRequestResponseModel: Codable {
    let BANK_NAME: String?
    let CHECKERNAME: String?
    let CHECKR_USR_CODE: Int?
    let CHECK_DATE: String?
    let CLA_CLIENT_NAME: String?
    let CLE_CLIENT_NAME: String?
    let CLOSE_PRICE: Double?
    let COMP_ID: Int?
    let E_I_DESC: String?
    let E_I_DESC_TO: String?
    let E_M_NAME: String?
    let FROM_ACC: Int64?
    let FROM_ACC_NAME: String?
    let FROM_ACC_TYPE: String?
    let ISIN_CODE: String?
    let I_DESC: String?
    let I_DESC_TO: String?
    let MAIN_CLIENT_ID: Int64?
    let M_CODE: String?
    let M_NAME: String?
    let NIN: String?
    let PAYMENT_DESC: String?
    let PAYMENT_DESC_AR: String?
    let PRINTED: String?
    let Payment: String?
    let QTY: Double?
    let REJECT_REASON: String?
    let REQUEST_ID: Int?
    let REQ_DATE: String?
    let REQ_DATE_STR: String?
    let REQ_STATUS: String?
    let REQ_STATUS_DESC: String?
    let REQ_STATUS_DESC_AR: String?
    let REQ_TYPE: Int?
    let REQ_TYPE_DESC: String?
    let REQ_TYPE_DESC_AR: String?
    let Re_marks: String?
    let SCA_LONG_NAME: String?
    let SCE_LONG_NAME: String?
    let SEQ_REQ_ID: Int?
    let TICKER_ID: String?
    let TO_ACC: Int64?
    let TO_ACC_NAME: String?
    let TO_ACC_TYPE: String?
    let TRANSFER_AMOUNT: String?
    let TotalComm: String?
    let UPD_TIME: String?
    let USR_CODE: Int?
    let U_NAME: String?
    let createdBy: String?
}

struct GetB2bRequestUIModel {
    var BANK_NAME: String?
    var CHECKERNAME: String?
    var CHECKR_USR_CODE: Int?
    var CHECK_DATE: String?
    var CLA_CLIENT_NAME: String?
    var CLE_CLIENT_NAME: String?
    var CLOSE_PRICE: Double?
    var COMP_ID: Int?
    var E_I_DESC: String?
    var E_I_DESC_TO: String?
    var E_M_NAME: String?
    var FROM_ACC: Int64?
    var FROM_ACC_NAME: String?
    var FROM_ACC_TYPE: String?
    var ISIN_CODE: String?
    var I_DESC: String?
    var I_DESC_TO: String?
    var MAIN_CLIENT_ID: Int64?
    var M_CODE: String?
    var M_NAME: String?
    var NIN: String?
    var PAYMENT_DESC: String?
    var PAYMENT_DESC_AR: String?
    var PRINTED: String?
    var Payment: String?
    var QTY: Double?
    var REJECT_REASON: String?
    var REQUEST_ID: Int?
    var REQ_DATE: String?
    var REQ_DATE_STR: String?
    var REQ_STATUS: String?
    var REQ_STATUS_DESC: String?
    var REQ_STATUS_DESC_AR: String?
    var REQ_TYPE: Int?
    var REQ_TYPE_DESC: String?
    var REQ_TYPE_DESC_AR: String?
    var Re_marks: String?
    var SCA_LONG_NAME: String?
    var SCE_LONG_NAME: String?
    var SEQ_REQ_ID: Int?
    var TICKER_ID: String?
    var TO_ACC: Int64?
    var TO_ACC_NAME: String?
    var TO_ACC_TYPE: String?
    var TRANSFER_AMOUNT: String?
    var TotalComm: String?
    var UPD_TIME: String?
    var USR_CODE: Int?
    var U_NAME: String?
    var createdBy: String?
}

extension GetB2bRequestUIModel {
    static func mapToUIModel(_ model: GetB2bRequestResponseModel) -> Self {
        return GetB2bRequestUIModel(
            BANK_NAME: model.BANK_NAME,
            CHECKERNAME: model.CHECKERNAME,
            CHECKR_USR_CODE: model.CHECKR_USR_CODE,
            CHECK_DATE: model.CHECK_DATE,
            CLA_CLIENT_NAME: model.CLA_CLIENT_NAME,
            CLE_CLIENT_NAME: model.CLE_CLIENT_NAME,
            CLOSE_PRICE: model.CLOSE_PRICE,
            COMP_ID: model.COMP_ID,
            E_I_DESC: model.E_I_DESC,
            E_I_DESC_TO: model.E_I_DESC_TO,
            E_M_NAME: model.E_M_NAME,
            FROM_ACC: model.FROM_ACC,
            FROM_ACC_NAME: model.FROM_ACC_NAME,
            FROM_ACC_TYPE: model.FROM_ACC_TYPE,
            ISIN_CODE: model.ISIN_CODE,
            I_DESC: model.I_DESC,
            I_DESC_TO: model.I_DESC_TO,
            MAIN_CLIENT_ID: model.MAIN_CLIENT_ID,
            M_CODE: model.M_CODE,
            M_NAME: model.M_NAME,
            NIN: model.NIN,
            PAYMENT_DESC: model.PAYMENT_DESC,
            PAYMENT_DESC_AR: model.PAYMENT_DESC_AR,
            PRINTED: model.PRINTED,
            Payment: model.Payment,
            QTY: model.QTY,
            REJECT_REASON: model.REJECT_REASON,
            REQUEST_ID: model.REQUEST_ID,
            REQ_DATE: model.REQ_DATE,
            REQ_DATE_STR: model.REQ_DATE_STR,
            REQ_STATUS: model.REQ_STATUS,
            REQ_STATUS_DESC: model.REQ_STATUS_DESC,
            REQ_STATUS_DESC_AR: model.REQ_STATUS_DESC_AR,
            REQ_TYPE: model.REQ_TYPE,
            REQ_TYPE_DESC: model.REQ_TYPE_DESC,
            REQ_TYPE_DESC_AR: model.REQ_TYPE_DESC_AR,
            Re_marks: model.Re_marks,
            SCA_LONG_NAME: model.SCA_LONG_NAME,
            SCE_LONG_NAME: model.SCE_LONG_NAME,
            SEQ_REQ_ID: model.SEQ_REQ_ID,
            TICKER_ID: model.TICKER_ID,
            TO_ACC: model.TO_ACC,
            TO_ACC_NAME: model.TO_ACC_NAME,
            TO_ACC_TYPE: model.TO_ACC_TYPE,
            TRANSFER_AMOUNT: model.TRANSFER_AMOUNT,
            TotalComm: model.TotalComm,
            UPD_TIME: model.UPD_TIME,
            USR_CODE: model.USR_CODE,
            U_NAME: model.U_NAME,
            createdBy: model.createdBy
        )
    }
    
    static func initializer() -> Self {
        return GetB2bRequestUIModel()
    }
}

