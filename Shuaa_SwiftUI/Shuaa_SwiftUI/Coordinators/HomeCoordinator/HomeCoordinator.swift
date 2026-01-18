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
        AppUtility.shared.screenTransition(
            navigationController: navigationController,
            animationOptions: AppConstants.screenTransition,
            duration: AppConstants.screenTransitionDuration,
            animated: AppConstants.isScreenTransitionAnimated
        )

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
    
    func openMarketTimeSaleScene() {
        let viewModel = MarketTimeSaleViewModel(coordinator: self)
        let view = MarketTimeSaleScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openWatchlistScene() {
        let viewModel = WatchlistViewModel(coordinator: self)
        let view = WatchlistScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
