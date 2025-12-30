//
//  ResetPasswordAdvanceModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/10/2025.
//

import Foundation

struct ResetPasswordAdvanceRequestModel: Codable {
    let email: String
    let hdnKey: String
    let id: String
    let mobile: String
    let mobileType: String
    let nin: String
    let newUser: String
    let oldPassword: String
    let password: String
    let requestType: String
    let sessionID: String
    let tokenID: String
    let tradingNo: String
    let userIPAddress: String
    let userName: String
    let webCode: String
    let lang: String

    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case hdnKey = "HdnKey"
        case id = "ID"
        case mobile = "Mobile"
        case mobileType = "MobileType"
        case nin = "NIN"
        case newUser = "NewUser"
        case oldPassword = "OldPassword"
        case password = "Password"
        case requestType = "RequestType"
        case sessionID = "SessionID"
        case tokenID = "TokenID"
        case tradingNo = "TradingNo"
        case userIPAddress = "UserIPAddress"
        case userName = "UserName"
        case webCode = "WebCode"
        case lang = "lang"
    }
}

struct ResetPasswordAdvanceResponseModel: Codable {
    let brokerID: String?
    let curCode: String?
    let compInit: String?
    let email: String?
    let errorMsg: String?
    let errorMsgAR: String?
    let groupCode: String?
    let isAgreed: String?
    let isBiometric: String?
    let isDeleted: String?
    let isEnableOMSPLUS: String?
    let isFirstLogin: String?
    let isRenewed: String?
    let lastLoginDate: String?
    let mainClientId: String?
    let mobID: String?
    let mobType: String?
    let mobileNo: String?
    let nameFullNameA: String?
    let nameFullNameE: String?
    let otp: String?
    let passwordPolicy: PasswordPolicy?
    let registrationId: String?
    let sessionID: String?
    let status: String?
    let subscribedMarkets: [String]?
    let subscriptionDaysNotify: String?
    let subscriptionDaysRemaining: String?
    let subscriptionFeeAmt: String?
    let subscriptionFrom: String?
    let subscriptionTo: String?
    let trialsNumber: String?
    let uCode: String?
    let updateInfo: String?
    let userName: String?
    let userType: String?
    let webCode: String?
    let enforceChangePassword: String?
    let enforceKYC: String?
    let isExpiredDocument: Bool?
    let isIndividual: Bool?
    let isMigrationEligible: String?
    let isTermsAndConditions: String?
    let lockedSeconds: String?
    let tries: Int?

    enum CodingKeys: String, CodingKey {
        case brokerID = "BrokerID"
        case curCode = "CUR_CODE"
        case compInit = "CompInit"
        case email = "Email"
        case errorMsg = "ErrorMsg"
        case errorMsgAR = "ErrorMsgAR"
        case groupCode = "GroupCode"
        case isAgreed = "IsAgreed"
        case isBiometric = "IsBiometric"
        case isDeleted = "IsDeleted"
        case isEnableOMSPLUS = "IsEnableOMSPLUS"
        case isFirstLogin = "IsFirstLogin"
        case isRenewed = "IsRenewed"
        case lastLoginDate = "LastLoginDate"
        case mainClientId = "MainClientId"
        case mobID = "MobID"
        case mobType = "MobType"
        case mobileNo = "MobileNo"
        case nameFullNameA = "NameFullNameA"
        case nameFullNameE = "NameFullNameE"
        case otp = "OTP"
        case passwordPolicy = "PasswordPolicy"
        case registrationId = "RegistrationId"
        case sessionID = "SessionID"
        case status = "Status"
        case subscribedMarkets = "SubscribedMarkets"
        case subscriptionDaysNotify = "SubscriptionDaysNotify"
        case subscriptionDaysRemaining = "SubscriptionDaysRemaining"
        case subscriptionFeeAmt = "SubscriptionFeeAmt"
        case subscriptionFrom = "SubscriptionFrom"
        case subscriptionTo = "SubscriptionTo"
        case trialsNumber = "TrialsNumber"
        case uCode = "UCode"
        case updateInfo = "UpdateInfo"
        case userName = "UserName"
        case userType = "UserType"
        case webCode = "WebCode"
        case enforceChangePassword = "enforceChangePassword"
        case enforceKYC = "enforceKYC"
        case isExpiredDocument = "isExpiredDocument"
        case isIndividual = "isIndividual"
        case isMigrationEligible = "isMigrationEligible"
        case isTermsAndConditions = "isTermsAndConditions"
        case lockedSeconds = "lockedSeconds"
        case tries = "tries"
    }
}

struct ResetPasswordAdvanceUIModel {
    var brokerID: String?
    var curCode: String?
    var compInit: String?
    var email: String?
    var errorMsg: String?
    var errorMsgAR: String?
    var groupCode: String?
    var isAgreed: String?
    var isBiometric: String?
    var isDeleted: String?
    var isEnableOMSPLUS: String?
    var isFirstLogin: String?
    var isRenewed: String?
    var lastLoginDate: String?
    var mainClientId: String?
    var mobID: String?
    var mobType: String?
    var mobileNo: String?
    var nameFullNameA: String?
    var nameFullNameE: String?
    var otp: String?
    var passwordPolicy: PasswordPolicy?
    var registrationId: String?
    var sessionID: String?
    var status: String?
    var subscribedMarkets: [String]?
    var subscriptionDaysNotify: String?
    var subscriptionDaysRemaining: String?
    var subscriptionFeeAmt: String?
    var subscriptionFrom: String?
    var subscriptionTo: String?
    var trialsNumber: String?
    var uCode: String?
    var updateInfo: String?
    var userName: String?
    var userType: String?
    var webCode: String?
    var enforceChangePassword: String?
    var enforceKYC: String?
    var isExpiredDocument: Bool?
    var isIndividual: Bool?
    var isMigrationEligible: String?
    var isTermsAndConditions: String?
    var lockedSeconds: String?
    var tries: Int?

    static func mapToUIModel(_ model: ResetPasswordAdvanceResponseModel) -> Self {
        return ResetPasswordAdvanceUIModel(brokerID: model.brokerID, curCode: model.curCode, compInit: model.compInit, email: model.email, errorMsg: model.errorMsg, errorMsgAR: model.errorMsgAR, groupCode: model.groupCode, isAgreed: model.isAgreed, isBiometric: model.isBiometric, isDeleted: model.isDeleted, isEnableOMSPLUS: model.isEnableOMSPLUS, isFirstLogin: model.isFirstLogin, isRenewed: model.isRenewed, lastLoginDate: model.lastLoginDate, mainClientId: model.mainClientId, mobID: model.mobID, mobType: model.mobType, mobileNo: model.mobileNo, nameFullNameA: model.nameFullNameA, nameFullNameE: model.nameFullNameE, otp: model.otp, passwordPolicy: model.passwordPolicy, registrationId: model.registrationId, sessionID: model.sessionID, status: model.status, subscribedMarkets: model.subscribedMarkets, subscriptionDaysNotify: model.subscriptionDaysNotify, subscriptionDaysRemaining: model.subscriptionDaysRemaining, subscriptionFeeAmt: model.subscriptionFeeAmt, subscriptionFrom: model.subscriptionFrom, subscriptionTo: model.subscriptionTo, trialsNumber: model.trialsNumber, uCode: model.uCode, updateInfo: model.updateInfo, userName: model.userName, userType: model.userType, webCode: model.webCode, enforceChangePassword: model.enforceChangePassword, enforceKYC: model.enforceKYC, isExpiredDocument: model.isExpiredDocument, isIndividual: model.isIndividual, isMigrationEligible: model.isMigrationEligible, isTermsAndConditions: model.isTermsAndConditions, lockedSeconds: model.lockedSeconds, tries: model.tries)
    }
    
    static func initializer() -> Self {
        return ResetPasswordAdvanceUIModel()
    }
}
