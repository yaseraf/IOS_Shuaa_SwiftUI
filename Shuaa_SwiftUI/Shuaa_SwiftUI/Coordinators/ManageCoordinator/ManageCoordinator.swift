//
//  HomeCoorindator.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

class ManageCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
        openManageScene()
    }

    func restart() {
        start()
    }
}
extension ManageCoordinator:ManageCoordinatorProtocol{

    func openManageScene() {
        let viewModel = ManageViewModel(coordinator: self)
        let view = ManageScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openSettingScene() {
        let viewModel = SettingViewModel(coordinator: self)
        let view = SettingScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTransactionScene() {
        let viewModel = TransactionsViewModel(coordinator: self)
        let view = TransactionScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openCashInScene() {
        let useCase = HomeUseCase()
        let viewModel = CashInViewModel(coordinator: self, useCase: useCase)
        let view = CashInScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openCashOutScene() {
        let useCase = HomeUseCase()
        let viewModel = CashOutViewModel(coordinator: self, useCase: useCase)
        let view = CashOutScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openSharesTransferScene() {
        let useCase = HomeUseCase()
        let viewModel = SharesTransferViewModel(coordinator: self, useCase: useCase)
        let view = SharesTransferScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMyAccountsScene() {
        let viewModel = MyAccountsViewModel(coordinator: self)
        let view = MyAccountsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTransactionDetailsScene(transactionAmount: String, fromAccount: String?, status:TransactionStatus?, statusDesc: String?, transactionType: String?, transactionDate: String?) {
        let viewModel = TransactionDetailsViewModel(coordinator: self, transactionAmount: transactionAmount, fromAccount: fromAccount, status: status, statusDesc: statusDesc, transactionType: transactionType, transactionDate: transactionDate)
        let view = TransactionDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTransactionHistoryScene() {
        let useCase = HomeUseCase()
        let viewModel = TransactionHistoryViewModel(coordinator: self, useCase: useCase)
        let view = TransactionHistoryScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    
    func openContactUsScene() {
        let viewModel = ContactUsViewModel(coordinator: self)
        let view = ContactUsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openAppRatingScene() {
        let viewModel = AppRatingViewModel(coordinator: self)
        let view = AppRatingScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMarketSummaryScene() {
        let useCase = HomeUseCase()
        let viewModel = MarketSummaryViewModel(coordinator: self, useCase: useCase)
        let view = MarketSummaryScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMarketReportsScene() {
        let useCase = HomeUseCase()
        let viewModel = MarketReportsViewModel(coordinator: self, useCase: useCase)
        let view = MarketReportsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openIndustrialSectorScene() {
        let useCase = HomeUseCase()
        let viewModel = IndustrialSectorViewModel(coordinator: self, useCase: useCase)
        let view = IndustrialSectorScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTradeIndexScene() {
        let useCase = HomeUseCase()
        let viewModel = TradeIndexViewModel(coordinator: self, useCase: useCase)
        let view = TradeIndexScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openIndustrialCompaniesScene(delegate: IndustrialCompaniesDelegate) {
        let useCase = HomeUseCase()
        let viewModel = IndustrialCompaniesViewModel(coordinator: self, delegate: delegate, useCase: useCase)
        let view = IndustrialCompaniesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.large()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openMarketDealsScene() {
        let viewModel = MarketDealsViewModel(coordinator: self)
        let view = MarketDealsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openNewsScene(newsData: [GetAllMarketNewsBySymbolUIModel]) {
        let viewModel = NewsViewModel(coordinator: self, newsData: newsData)
        let view = NewsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openListOfCompaniesScene() {
        let useCase = LookupsUseCase()
        let homeUseCase = HomeUseCase()
        let viewModel = ListOfCompaniesViewModel(coordinator: self, useCase: useCase, homeUseCase: homeUseCase)
        let view = ListOfCompaniesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openNotificationsScene() {
        let useCase = MenuUseCase()
        let viewModel = NotificationsViewModel(coordinator: self, useCase: useCase)
        let view = NotificationsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openAccountReportsScene() {
        let useCase = MenuUseCase()
        let viewModel = AccountSummaryViewModel(coordinator: self, menuUseCase: useCase)
        let view = AccountSummaryScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openManageChangePasswordScene() {
        let useCase = HomeUseCase()
        let viewModel = ManageChangePasswordViewModel(coordinator: self, useCase: useCase)
        let view = ManageChangePasswordScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openDocumentsScene() {
        let useCase = HomeUseCase()
        let viewModel = DocumentsViewModel(coordinator: self, useCase: useCase)
        let view = DocumentsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openInsertDocumentsScene(idNumber: String) {
        let useCase = HomeUseCase()
        let viewModel = InsertDocumentViewModel(coordinator: self, useCase: useCase, idNumber: idNumber)
        let view = InsertDocumentScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openBalanceDetailsScene() {
        let useCase = PortfolioUseCase()
        let viewModel = BalanceDetailsViewModel(coordinator: self, useCase: useCase)
        let view = BalanceDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openLogoutConfirmationScene() {
        let useCase = UsersLogOffUseCase()
        let viewModel = LogoutConfirmationViewModel(coordinator: self, usersLogOffUseCase: useCase)
        let view = LogoutConfirmationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
}
