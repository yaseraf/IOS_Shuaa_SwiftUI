//
//  OrderListCoorindator.swift
//  Shuaa

import Foundation
import SwiftUI
import FlagAndCountryCode

class PortfolioCoordinator:  ObservableObject {
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
        
        openPortfolioScene()
    }

    func restart() {
        start()
    }
    
}

extension PortfolioCoordinator:PortfolioCoordinatorProtocol {

    func openPortfolioScene() {
        let viewModel = PortfolioViewModel(coordinator: self)
        let view = PortfolioScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
