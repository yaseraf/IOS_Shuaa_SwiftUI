//
//  UpdateIdValidity3Model.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/10/2025.
//

import Foundation

struct UpdateIdValidity3RequestModel: Codable {
    let clientID: String
    let docType: String
    let fileName: String
    let fileName2: String
    let fileType: String
    let fileType2: String
    let idNumber: String
    let isBase64: String
    let imageFile: [Int]
    let imageFile2: [Int]
    let issueDate: String
    let mainClientID: String
    let requestID: Int
    let typeCode: String
    let validityDate: String
    let webCode: String
    let isIndivual: Bool

    enum CodingKeys: String, CodingKey {
        case clientID = "ClientID"
        case docType = "Doc_type"
        case fileName = "FileName"
        case fileName2 = "FileName2"
        case fileType = "FileType"
        case fileType2 = "FileType2"
        case idNumber = "IDNumber"
        case isBase64 = "ISBase64"
        case imageFile = "ImageFile"
        case imageFile2 = "ImageFile2"
        case issueDate = "IssueDate"
        case mainClientID = "MainClientID"
        case requestID = "RequestID"
        case typeCode = "TypeCode"
        case validityDate = "ValidityDate"
        case webCode = "WebCode"
        case isIndivual = "isIndivual"
    }
}

struct UpdateIdValidity3ResponseModel: Codable {
    let isSuccess: Bool?
}


struct UpdateIdValidity3UIModel {
    var isSuccess: Bool?
    
    static func mapToUIModel(_ model: UpdateIdValidity3ResponseModel) -> Self {
        return UpdateIdValidity3UIModel(isSuccess: model.isSuccess)
    }
    
    static func initializer() -> Self {
        return UpdateIdValidity3UIModel()
    }
}
