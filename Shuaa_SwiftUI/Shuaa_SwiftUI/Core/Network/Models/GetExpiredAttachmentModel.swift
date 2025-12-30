//
//  GetRequiredUserDocumentsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation

struct GetExpiredAttachmentRequestModel: Codable {
    
}

struct GetExpiredAttachmentResponseModel: Codable {
    let backOfficeIDValidityResult: [BackOfficeIDValidityResult]?
    let etradeIDValidityResult: [EtradeIDValidityResult]?
    
    enum CodingKeys: String, CodingKey {
        case backOfficeIDValidityResult = "BackOfficeIDValidityResult"
        case etradeIDValidityResult = "EtradeIDValidityResult"
    }
}


struct GetExpiredAttachmentUIModel {
    var backOfficeIDValidityResult: [BackOfficeIDValidityResult]?
    var etradeIDValidityResult: [EtradeIDValidityResult]?

    static func mapToUIModel(_ model: GetExpiredAttachmentResponseModel) -> Self {
        return GetExpiredAttachmentUIModel(backOfficeIDValidityResult: model.backOfficeIDValidityResult, etradeIDValidityResult: model.etradeIDValidityResult)
    }
    
    static func initializer() -> Self {
        return GetExpiredAttachmentUIModel()
    }
}
