//
//  DocumentsModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 18/01/2026.
//

import Foundation

struct DocumentsUIModel {
    var documentType: String?
    var documentStatus: String?
    
    static func initializer() -> Self {
        return DocumentsUIModel()
    }
    
    static func initMockData() -> [Self] {
        return [
            DocumentsUIModel(
                documentType: "Passport",
                documentStatus: "Expired"
            ),
            DocumentsUIModel(
                documentType: "NID",
                documentStatus: "Active"
            ),
        ]
    }
}
