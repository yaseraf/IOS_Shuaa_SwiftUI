//
//  SubmitShareTransferReqModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/10/2025.
//

import Foundation

struct SubmitShareTransferReqRequestModel: Codable {
    var USR_CODE: Double?
    var REQUEST_ID: Double?
    var MAIN_CLIENT_ID: Double?
    var SEQ_REQ_ID: Double?
    var REQ_DATE_STR: String?
    var REQ_TYPE: Double?
    var FROM_ACC: Double?
    var TO_ACC: Double?
    var FROM_ACC_TYPE: String?
    var TO_ACC_TYPE: String?
    var M_CODE: String?
    var COMP_ID: String?
    var QTY: Double?
    var CLOSE_PRICE: Double?
}

struct SubmitShareTransferReqResponseModel: Codable {
    let result: Bool?
}

struct SubmitShareTransferReqUIModel {
    var result: Bool?

    static func mapToUIModel(_ model: SubmitShareTransferReqResponseModel) -> Self {
        return SubmitShareTransferReqUIModel(result: model.result)
    }
    
    static func initializer() -> Self {
        return SubmitShareTransferReqUIModel()
    }
}
