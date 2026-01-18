//
//  AppCoordinatorProtocol.swift
//  Shuaa

import Foundation

protocol AppCoordinatorProtocol: AnyObject,Coordinator {
    func startFlow(startWith:AuthCoordinator.AuthStartSceneType)
    func showHomeFlow()
    func showOrderListFlow()
    func showTradeFlow()
    func showAccountsFlow()
    func showPortfolioFlow()
    func removeAllChildCoordinator()
    func openAccountInformationScene()
    func openMyDocumentsScene()
    func openMarketsInsightScene()
    func openNotificationsScene()
    func openAlertsScene()
    func openAccountStatementsScene()
    func openCashDepositScene()
    func openEquityTransferScene()
    func openTransfersScene()
    func openMyAccountScene()
    func openClientPortalScene()
    func openIPOScene()
    func openSettingsScene()
}
