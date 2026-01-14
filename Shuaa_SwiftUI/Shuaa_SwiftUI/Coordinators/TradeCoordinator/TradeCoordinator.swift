//
//  OrderListCoorindator.swift
//  Shuaa

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
        AppUtility.shared.screenTransition(
            navigationController: navigationController,
            animationOptions: AppConstants.screenTransition,
            duration: AppConstants.screenTransitionDuration,
            animated: AppConstants.isScreenTransitionAnimated
        )
        
        openTradeScene()
    }

    func restart() {
        start()
    }
    
}

extension TradeCoordinator:TradeCoordinatorProtocol {

    func openTradeScene() {
        let viewModel = TradeViewModel(coordinator: self)
        let view = TradeScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
