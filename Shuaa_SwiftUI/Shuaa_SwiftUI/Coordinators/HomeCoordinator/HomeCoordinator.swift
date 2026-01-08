//
//  HomeCoorindator.swift
//  Shuaa

import Foundation
import SwiftUI
import FlagAndCountryCode

class HomeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        AppUtility.shared.screenTransition(navigationController: navigationController, animationOptions: .transitionCrossDissolve, duration: 0.3, animated: false)
        openHomeScene()
    }

    func restart() {
        start()
    }
    
}

extension HomeCoordinator:HomeCoordinatorProtocol {

    func openHomeScene() {
        let viewModel = HomeViewModel(coordinator: self)
        let view = HomeScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openSettingsScene() {
        let viewModel = SettingsViewModel(coordinator: self)
        let view = SettingsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMarketOverviewScene() {
        let viewModel = MarketOverviewViewModel(coordinator: self)
        let view = MarketOverviewScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTopStocksScene() {
        let viewModel = TopStocksViewModel(coordinator: self)
        let view = TopStocksScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
