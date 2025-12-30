//
//  RegistrationsOTPModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/10/2025.
//

import Foundation

struct RegistrationsOTPRequestModel: Codable {
    var deviceID: String?
    var emailAddress: String?
    var fileName: String?
    var fileType: String?
    var fingerPrintID: String?
    var fingerPrintLevel: String?
    var guid: String?
    var hdnKey: String?
    var idNumber: String?
    var mainClientId: String?
    var mobileNo: String?
    var mobileType: String?
    var newUser: String?
    var oldPassword: String?
    var password: String?
    var password2: String?
    var registrationId: String?
    var sessionID: String?
    var tokenID: String?
    var touchToken: String?
    var tradingNo: String?
    var uploadFile: [String]?
    var userIPAddress: String?
    var userName: String?
    var validityDate: String?
    var versionNumber: String?
    var webCode: String?
    var isAuthorizeOnly: String?
    var isIPOQuickSell: String?
    
    enum CodingKeys: String, CodingKey {
        case deviceID = "DeviceID"
        case emailAddress = "Email_Address"
        case fileName = "FileName"
        case fileType = "FileType"
        case fingerPrintID = "FingerPrintID"
        case fingerPrintLevel = "FingerPrintLevel"
        case guid = "GUID"
        case hdnKey = "HdnKey"
        case idNumber = "IDNumber"
        case mainClientId = "MainClientId"
        case mobileNo = "MobileNo"
        case mobileType = "MobileType"
        case newUser = "NewUser"
        case oldPassword = "OldPassword"
        case password = "Password"
        case password2 = "Password2"
        case registrationId = "RegistrationId"
        case sessionID = "SessionID"
        case tokenID = "TokenID"
        case touchToken = "TouchToken"
        case tradingNo = "TradingNo"
        case uploadFile = "UploadFile"
        case userIPAddress = "UserIPAddress"
        case userName = "UserName"
        case validityDate = "ValidityDate"
        case versionNumber = "VersionNumber"
        case webCode = "WebCode"
        case isAuthorizeOnly = "isAuthorizeOnly"
        case isIPOQuickSell = "isIPOQuickSell"
    }
}

struct RegistrationsOTPResponseModel: Codable {
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


struct RegistrationsOTPUIModel {
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
    
    
    
    static func mapToUIModel(_ model: RegistrationsOTPResponseModel) -> Self {
        return RegistrationsOTPUIModel(brokerID: model.brokerID, curCode: model.curCode, compInit: model.compInit, email: model.email, errorMsg: model.errorMsg, errorMsgAR: model.errorMsgAR, groupCode: model.groupCode, isAgreed: model.isAgreed, isBiometric: model.isBiometric, isDeleted: model.isDeleted, isEnableOMSPLUS: model.isEnableOMSPLUS, isFirstLogin: model.isFirstLogin, isRenewed: model.isRenewed, lastLoginDate: model.lastLoginDate, mainClientId: model.mainClientId, mobID: model.mobID, mobType: model.mobType, mobileNo: model.mobileNo, nameFullNameA: model.nameFullNameA, nameFullNameE: model.nameFullNameE, otp: model.otp, passwordPolicy: model.passwordPolicy, registrationId: model.registrationId, sessionID: model.sessionID, status: model.status, subscribedMarkets: model.subscribedMarkets, subscriptionDaysNotify: model.subscriptionDaysNotify, subscriptionDaysRemaining: model.subscriptionDaysRemaining, subscriptionFeeAmt: model.subscriptionFeeAmt, subscriptionFrom: model.subscriptionFrom, subscriptionTo: model.subscriptionTo, trialsNumber: model.trialsNumber, uCode: model.uCode, updateInfo: model.updateInfo, userName: model.userName, userType: model.userType, webCode: model.webCode, enforceChangePassword: model.enforceChangePassword, enforceKYC: model.enforceKYC, isExpiredDocument: model.isExpiredDocument, isIndividual: model.isIndividual, isMigrationEligible: model.isMigrationEligible, isTermsAndConditions: model.isTermsAndConditions, lockedSeconds: model.lockedSeconds, tries: model.tries)
    }
    
    static func initializer() -> Self {
        return RegistrationsOTPUIModel()
    }
}
