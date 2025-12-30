//
//  DeleteAlertModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 06/10/2025.
//

import Foundation
struct DeleteAlertRequestModel: Codable {
    
}

struct DeleteAlertResponseModel: Codable {
    
}

struct DeleteAlertUIModel{

}

extension DeleteAlertUIModel {
    static func mapToUIModel(_ model:DeleteAlertResponseModel)->Self {
        return  DeleteAlertUIModel()
    }

}
