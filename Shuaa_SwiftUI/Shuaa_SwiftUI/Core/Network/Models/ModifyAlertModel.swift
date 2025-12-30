//
//  ModifyAlertModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 06/10/2025.
//

import Foundation

struct ModifyAlertRequestModel: Codable {
    let alertID, bySMS, condition, conditionName: String?
        let conditionValue, customMsg, exchange, symbol, validity: String?
        let webCode: String?

        enum CodingKeys: String, CodingKey {
            case alertID = "AlertID"
            case bySMS = "BySMS"
            case condition = "Condition"
            case conditionName = "ConditionName"
            case conditionValue = "ConditionValue"
            case customMsg = "CustomMsg"
            case exchange = "Exchange"
            case symbol = "Symbol"
            case validity = "Validity"
            case webCode = "WebCode"
        }
}

struct ModifyAlertResponseModel: Codable {
    let alertCondition, alertID, bySMS, companyShortNameA: String?
        let companyShortNameE, condition, conditionName, conditionValue: String?
        let customMsg, exchange, executed, notificationAction: String?
        let symbol, validity, webcode: String?

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

struct ModifyAlertUIModel{
    let alertCondition, alertID, bySMS, companyShortNameA: String?
        let companyShortNameE, condition, conditionName, conditionValue: String?
        let customMsg, exchange, executed, notificationAction: String?
        let symbol, validity, webcode: String?
}

extension ModifyAlertUIModel {
    static func mapToUIModel(_ model:ModifyAlertResponseModel)->Self {
        return  ModifyAlertUIModel(alertCondition: model.alertCondition, alertID: model.alertID, bySMS: model.bySMS, companyShortNameA: model.companyShortNameA, companyShortNameE: model.companyShortNameE, condition: model.condition, conditionName: model.conditionName, conditionValue: model.conditionValue, customMsg: model.customMsg, exchange: model.exchange, executed: model.executed, notificationAction: model.notificationAction, symbol: model.symbol, validity: model.validity, webcode: model.webcode)
    }
    
    static func testUIModel()->Self {
        return ModifyAlertUIModel(alertCondition: "", alertID: "", bySMS: "", companyShortNameA: "", companyShortNameE: "", condition: "", conditionName: "", conditionValue: "", customMsg: "", exchange: "", executed: "", notificationAction: "", symbol: "", validity: "", webcode: "")
    }
}
