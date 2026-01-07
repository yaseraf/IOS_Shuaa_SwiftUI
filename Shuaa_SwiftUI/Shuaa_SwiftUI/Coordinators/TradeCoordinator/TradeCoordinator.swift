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

class TradeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        self.navigationController.viewControllers = []
        
        AppUtility.shared.screenTransition(navigationController: navigationController, animationOptions: .transitionCrossDissolve, duration: 0.3, animated: false)

        openOrderListScene()
    }

    func restart() {
        start()
    }
}
extension TradeCoordinator:TradeCoordinatorProtocol{

    func openOrderListScene() {
        let useCase = LookupsUseCase()
        let viewModel = OrderListViewModel(coordinator: self, useCase: useCase)
        let view = OrderListScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTradeScene(stock: GetCompaniesLookupsUIModel, typeOfTrade: TypeOfTrade, isEditOrder: Bool = false, orderDetails: OrderListUIModel) {
        let useCase = TradeUseCase()
        let viewModel = TradeViewModel(coordinator: self, useCase: useCase, selectedStock: stock, typeOfTrade: typeOfTrade, isEditOrder: isEditOrder, orderDetails: orderDetails)
        let view = TradeScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openQuantityCalculatorScene(delegate: QuantityCalculatorDelegate, lastTradePrice: String) {
        let useCase = TradeUseCase()
        let viewModel = QuantityCalculatorViewModel(coordinator: self, useCase: useCase, delegate: delegate, lastTradePrice: lastTradePrice)
        let view = QuantityCalculatorScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openTradeConfrimationScene(shares: String, price: String, value: String, expiryDate: String, selectedTypeOfTrade: TypeOfTrade, orderPreview: OrderPreviewModel, riskManagementData: GetRiskManagementUIModel, isEditOrder: Bool) {
        let viewModel = TradeConfirmationViewModel(coordinator: self, shares: shares, price: price, value: value, expiryDate: expiryDate, selectedTypeOfTrade: selectedTypeOfTrade, orderPreview: orderPreview, riskManagementData: riskManagementData, isEditOrder: isEditOrder)
        let view = TradeConfirmationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openOrderDetailsScene(orderDetails: OrderListUIModel, delegate: OrderDetailsDelegate) {
        let viewModel = OrderDetailsViewModel(coordinator: self, orderDetails: orderDetails, delegate: delegate)
        let view = OrderDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
}
