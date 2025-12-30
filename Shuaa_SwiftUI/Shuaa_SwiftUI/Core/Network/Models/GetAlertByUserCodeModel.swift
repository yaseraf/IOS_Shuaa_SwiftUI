//
//  GetAlertByUserCodeModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/09/2025.
//

import Foundation

struct GetAlertByUserCodeRequestModel: Codable {
    
}

struct GetAlertByUserCodeResponseModel: Codable {
    let alertCondition: String?
    let alertID: String?
    let bySMS: String?
    let companyShortNameA: String?
    let companyShortNameE: String?
    let condition: String?
    let conditionName: String?
    let conditionValue: String?
    let customMsg: String?
    let exchange: String?
    let executed: String?
    let notificationAction: String?
    let symbol: String?
    let validity: String?
    let webcode: String?

    enum CodingKeys: String, CodingKey {
        case alertCondition = "AlertCondition"
        case alertID = "AlertID"
        case bySMS = "BySMS"
        case companyShortNameA = "CompanyShortNameA"
        case companyShortNameE = "CompanyShortNameE"
        case condition = "Condition"
        case conditionName = "ConditionName"
        case conditionValue = "ConditionValue"
        case customMsg = "CustomMsg"
        case exchange = "Exchange"
        case executed = "Executed"
        case notificationAction = "NotificationAction"
        case symbol = "Symbol"
        case validity = "Validity"
        case webcode = "Webcode"
    }

}

struct GetAlertByUserCodeUIModel {
    var alertCondition: String?
    var alertID: String?
    var bySMS: String?
    var companyShortNameA: String?
    var companyShortNameE: String?
    var condition: String?
    var conditionName: String?
    var conditionValue: String?
    var customMsg: String?
    var exchange: String?
    var executed: String?
    var notificationAction: String?
    var symbol: String?
    var validity: String?
    var webcode: String?


    static func mapToUIModel(_ model:GetAlertByUserCodeResponseModel) -> Self {
        return GetAlertByUserCodeUIModel(alertCondition: model.alertCondition, alertID: model.alertID, bySMS: model.bySMS, companyShortNameA: model.companyShortNameA, companyShortNameE: model.companyShortNameE, condition: model.condition, conditionName: model.conditionName, conditionValue: model.conditionValue, customMsg: model.customMsg, exchange: model.exchange, executed: model.executed, notificationAction: model.notificationAction, symbol: model.symbol, validity: model.validity, webcode: model.webcode)
    }
    
    static func initializer() -> Self {
        return GetAlertByUserCodeUIModel()
    }
}
