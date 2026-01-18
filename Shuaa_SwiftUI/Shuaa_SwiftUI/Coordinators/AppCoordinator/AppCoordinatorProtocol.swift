//
//  AppCoordinatorProtocol.swift
//  Shuaa

import Foundation

protocol AppCoordinatorProtocol: AnyObject,Coordinator {
    func startFlow(startWith:AuthCoordinator.AuthStartSceneType)
    func showHomeFlow()
    func openAccountInformationScene()
    func openMyDocumentsScene()
    func openMarketsInsightScene()
    func openAlertsScene()
    func openAddAlertsScene()
    func openAccountStatementsScene()
    func openCashDepositScene()
    func openEquityTransferScene()
    func openTransfersScene()
    func openMyAccountScene()
    func openIPOScene()
    func openSettingsScene()
}
