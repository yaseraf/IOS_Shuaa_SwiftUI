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
    var balance: Double?
    var buyPower: Double?
    var expectedProfitLoss: Double?
    var availableCash: Double?
    var realisedProfitLoss: Double?
    var facilityAmount: Double?
    var costValue: Double?
    var marketValue: Double?
    var netProfitLoss: Double?
    var netPortfolioValue: Double?
    
    static func initializer() -> Self {
        return UserAccountsUIModel()
    }
    
    static func initMockData() -> Self {
        return UserAccountsUIModel(accountName: "Account", accountNumber: "2933878", currency: "AED", balance: 1, buyPower: 0, expectedProfitLoss: 0, availableCash: 0, realisedProfitLoss: 0, facilityAmount: 0, costValue: 0, marketValue: 0, netProfitLoss: 0, netPortfolioValue: 0)
    }
}
