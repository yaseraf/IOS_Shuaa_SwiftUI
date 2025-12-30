//
//  UploadClientDocumentsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation

struct UploadClientDocumentsRequestModel: Codable {
    var A_DESC: String?
    var ClientID: String?
    var E_DESC: String?
    var ExpiryDate: String?
    var FileType: String?
    var IDNumber: String?
    var ISBase64: String?
    var ImageFile: [Int]?
    var ImageFileString: String?
    var IssueDate: String?
    var MainClientID: String?
    var WebCode: String?
    var isIBAN: String?
}

struct UploadClientDocumentsResponseModel: Codable {
    
}

struct UploadClientDocumentsUIModel {
    
    static func mapToUIModel(_ model: UploadClientDocumentsResponseModel) -> Self {
        return UploadClientDocumentsUIModel()
    }
    
    static func initializer() -> Self {
        return UploadClientDocumentsUIModel()
    }
}
