//
//  AddAlertModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 06/10/2025.
//

import Foundation

struct AddAlertRequestModel: Codable {
    
}

struct AddAlertResponseModel: Codable {
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

struct AddAlertUIModel{
       var alertCondition, alertID, bySMS, condition: String?
       var conditionName, conditionValue, customMsg, exchange: String?
       var executed, notificationAction, symbol, validity: String?
       var webcode: String?
}

extension AddAlertUIModel {
    static func mapToUIModel(_ model:AddAlertResponseModel)->Self {
        return  AddAlertUIModel(alertCondition: model.alertCondition ?? "", alertID: model.alertID ?? "", bySMS: model.bySMS ?? "", condition: model.condition ?? "", conditionName: model.conditionName ?? "", conditionValue: model.conditionValue ?? "", customMsg: model.customMsg ?? "", exchange: model.exchange ?? "", executed: model.executed ?? "", notificationAction: model.notificationAction ?? "", symbol: model.symbol ?? "", validity: model.validity ?? "", webcode: model.webcode ?? "")
    }
}
