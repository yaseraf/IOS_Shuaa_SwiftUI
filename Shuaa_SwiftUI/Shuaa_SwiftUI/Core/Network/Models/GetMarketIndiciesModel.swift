//
//  GetMarketIndiciesModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/10/2025.
//

import Foundation

struct GetMarketIndiciesRequestModel: Codable {
    
}

struct GetMarketIndiciesResponseModel: Codable {
    let CIA_DESC: String?
    let CIE_DESC: String?
    let CI_BASIC_VALUE: String?
    let CI_CHG_INDEX: String?
    let CI_CHG_PERC_INDEX: String?
    let CI_CURRENT_INDEX: String?
    let CI_EXCHANGE: String?
    let CI_HIGH_INDEX: String?
    let CI_LOW_INDEX: String?
    let CI_OPEN_INDEX: String?
    let CI_SECTOR: String?
    let DayRange: String?
    let wk52High: Double?
    let wk52Low: Double?
    let wk52Range: String?
}

struct GetMarketIndiciesUIModel {
    var CIA_DESC: String?
    var CIE_DESC: String?
    var CI_BASIC_VALUE: String?
    var CI_CHG_INDEX: String?
    var CI_CHG_PERC_INDEX: String?
    var CI_CURRENT_INDEX: String?
    var CI_EXCHANGE: String?
    var CI_HIGH_INDEX: String?
    var CI_LOW_INDEX: String?
    var CI_OPEN_INDEX: String?
    var CI_SECTOR: String?
    var DayRange: String?
    var wk52High: Double?
    var wk52Low: Double?
    var wk52Range: String?
    
    static func mapToUIModel(_ model: GetMarketIndiciesResponseModel) -> Self {
        return GetMarketIndiciesUIModel(CIA_DESC: model.CIA_DESC, CIE_DESC: model.CIE_DESC, CI_BASIC_VALUE: model.CI_BASIC_VALUE, CI_CHG_INDEX: model.CI_CHG_INDEX, CI_CHG_PERC_INDEX: model.CI_CHG_PERC_INDEX, CI_CURRENT_INDEX: model.CI_CURRENT_INDEX, CI_EXCHANGE: model.CI_EXCHANGE, CI_HIGH_INDEX: model.CI_HIGH_INDEX, CI_LOW_INDEX: model.CI_LOW_INDEX, CI_OPEN_INDEX: model.CI_OPEN_INDEX, CI_SECTOR: model.CI_SECTOR, DayRange: model.DayRange, wk52High: model.wk52High, wk52Low: model.wk52Low, wk52Range: model.wk52Range)
    }
    
    static func initializer() -> Self {
        return GetMarketIndiciesUIModel()
    }
}
