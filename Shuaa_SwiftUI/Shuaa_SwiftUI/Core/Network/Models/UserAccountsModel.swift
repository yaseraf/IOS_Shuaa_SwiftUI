//
//  UserAccountsModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation

struct UserAccountsUIModel {
    var accountName: String?
    var accountNumber: String?
    var currency: String?
    
    static func initializer() -> Self {
        return UserAccountsUIModel()
    }
    
    static func initMockData() -> Self {
        return UserAccountsUIModel(accountName: "Account", accountNumber: "2933878", currency: "AED")
    }
}
