//
//  GetShareTransferLogWithDetailsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 09/12/2025.
//

import Foundation

struct GetShareTransferLogWithDetailsRequestModel: Codable {
    
}

struct GetShareTransferLogWithDetailsResponseModel: Codable {
    let CHECK_DATE: String?
    let PAYMENT_DESC: String?
    let PAYMENT_DESC_AR: String?
    let PRINTED: String?
    let Payment: String?
    let REQUEST_ID: Int?
    let REQ_DATE: String?
    let REQ_STATUS: String?
    let REQ_STATUS_DESC: String?
    let REQ_STATUS_DESC_AR: String?
    let REQ_TYPE: Int?
    let REQ_TYPE_DESC: String?
    let REQ_TYPE_DESC_AR: String?
    let Re_marks: String?
    let TotalComm: String?
    let UPD_TIME: String?
    let USR_CODE: Int?
    let U_NAME: String?
    let details: [ShareTransferDetailResponseModel]?
}

struct ShareTransferDetailResponseModel: Codable {
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

struct GetShareTransferLogWithDetailsUIModel {
    var checkDate: String?
    var paymentDesc: String?
    var paymentDescAr: String?
    var printed: String?
    var payment: String?
    var requestId: Int?
    var reqDate: String?
    var reqStatus: String?
    var reqStatusDesc: String?
    var reqStatusDescAr: String?
    var reqType: Int?
    var reqTypeDesc: String?
    var reqTypeDescAr: String?
    var remarks: String?
    var totalComm: String?
    var updTime: String?
    var usrCode: Int?
    var uName: String?
    var details: [ShareTransferDetailResponseModel]?
    
    static func mapToUIModel(_ model: GetShareTransferLogWithDetailsResponseModel) -> Self {
        return GetShareTransferLogWithDetailsUIModel(
            checkDate: model.CHECK_DATE,
            paymentDesc: model.PAYMENT_DESC,
            paymentDescAr: model.PAYMENT_DESC_AR,
            printed: model.PRINTED,
            payment: model.Payment,
            requestId: model.REQUEST_ID,
            reqDate: model.REQ_DATE,
            reqStatus: model.REQ_STATUS,
            reqStatusDesc: model.REQ_STATUS_DESC,
            reqStatusDescAr: model.REQ_STATUS_DESC_AR,
            reqType: model.REQ_TYPE,
            reqTypeDesc: model.REQ_TYPE_DESC,
            reqTypeDescAr: model.REQ_TYPE_DESC_AR,
            remarks: model.Re_marks,
            totalComm: model.TotalComm,
            updTime: model.UPD_TIME,
            usrCode: model.USR_CODE,
            uName: model.U_NAME,
            details: model.details
        )
    }
    
    static func initializer() -> Self {
        return GetShareTransferLogWithDetailsUIModel()
    }
}
