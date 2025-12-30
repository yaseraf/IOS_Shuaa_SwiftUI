//
//  GetRequiredUserDocumentsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation

struct GetRequiredUserDocumentsRequestModel: Codable {
    
}

struct GetRequiredUserDocumentsResponseModel: Codable {
    let backOfficeIDValidityResult: [BackOfficeIDValidityResult]?
    let etradeIDValidityResult: [EtradeIDValidityResult]?
    
    enum CodingKeys: String, CodingKey {
        case backOfficeIDValidityResult = "BackOfficeIDValidityResult"
        case etradeIDValidityResult = "EtradeIDValidityResult"
    }
}

struct BackOfficeIDValidityResult: Codable {
    let clientID: String?
    let differenceDays: Int?
    let docType: String?
    let expiryDate: String?
    let idNumber: String?
    let issueDate: String?
    let mainClientID: String?
    let typeAr: String?
    let typeCode: String?
    let typeEn: String?
    
    enum CodingKeys: String, CodingKey {
        case clientID = "ClientID"
        case differenceDays = "DifferenceDays"
        case docType = "Doc_Type"
        case expiryDate = "ExpiryDate"
        case idNumber = "IDNumber"
        case issueDate = "IssueDate"
        case mainClientID = "MainClientID"
        case typeAr = "TypeAr"
        case typeCode = "TypeCode"
        case typeEn = "TypeEn"
    }
}

struct EtradeIDValidityResult: Codable {
    let approvalStatus: String?
    let docType: String?
    let expiryDate: String?
    let idNumber: String?
    let mainClientID: String?
    let rejectedReasonAr: String?
    let rejectedReasonEn: String?
    
    enum CodingKeys: String, CodingKey {
        case approvalStatus = "ApprovalStatus"
        case docType = "Doc_Type"
        case expiryDate = "ExpiryDate"
        case idNumber = "IDNUMBER"
        case mainClientID = "MainClientID"
        case rejectedReasonAr = "RejectedReasonAr"
        case rejectedReasonEn = "RejectedReasonEn"
    }
}

struct GetRequiredUserDocumentsUIModel {
    var backOfficeIDValidityResult: [BackOfficeIDValidityResult]?
    var etradeIDValidityResult: [EtradeIDValidityResult]?

    static func mapToUIModel(_ model: GetRequiredUserDocumentsResponseModel) -> Self {
        return GetRequiredUserDocumentsUIModel(backOfficeIDValidityResult: model.backOfficeIDValidityResult, etradeIDValidityResult: model.etradeIDValidityResult)
    }
    
    static func initializer() -> Self {
        return GetRequiredUserDocumentsUIModel()
    }
}
