//
//  AccountInformationModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 18/01/2026.
//

import Foundation

struct AccountInformationUIModel {
    var name: String?
    var clientID: String?
    var fullName: String?
    var phoneNumber: String?
    var email: String?
    var nin: String?
    var tradingAccount: String?
    
    static func initializer() -> Self {
        return AccountInformationUIModel()
    }
    
    static func initMockData() -> Self {
        return AccountInformationUIModel(name: "Account-2933933-USD", clientID: "fit", fullName: "Account-2933933-USD", phoneNumber: "+962797170930", email: "nedal@fitmena.com1", nin: "", tradingAccount: "")
    }
}
