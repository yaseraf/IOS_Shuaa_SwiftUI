//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol ManageCoordinatorProtocol: AnyObject,Coordinator {
//    func openManageScene()
//    func openSettingScene()
    func openTransactionScene()
    func openCashInScene()
    func openCashOutScene()
    func openSharesTransferScene()
    func openMyAccountsScene()
    func openTransactionDetailsScene(transactionAmount: String, fromAccount: String?, status:TransactionStatus?, statusDesc: String?, transactionType: String?, transactionDate: String?)
    func openTransactionHistoryScene()
    func openContactUsScene()
    func openAppRatingScene()
    func openMarketSummaryScene()
    func openMarketReportsScene()
    func openTradeIndexScene()
    func openIndustrialSectorScene()
    func openIndustrialCompaniesScene(delegate: IndustrialCompaniesDelegate)
    func openMarketDealsScene()
    func openNewsScene(newsData: [GetAllMarketNewsBySymbolUIModel])
    func openListOfCompaniesScene()
    func openNotificationsScene()
    func openAccountReportsScene()
    func openManageChangePasswordScene()
    func openDocumentsScene()
    func openInsertDocumentsScene(idNumber: String)
    func openBalanceDetailsScene()
    func openLogoutConfirmationScene()
}
