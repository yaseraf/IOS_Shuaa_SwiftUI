//
//  HomeCoorindator.swift
//  Shuaa

import Foundation
import SwiftUI
import FlagAndCountryCode

class OrderListCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        AppUtility.shared.screenTransition(navigationController: navigationController, animationOptions: .transitionCrossDissolve, duration: 0.3, animated: false)
        openOrderListScene()
    }

    func restart() {
        start()
    }
    
}

extension OrderListCoordinator:OrderListCoordinatorProtocol {

    func openOrderListScene() {
        let viewModel = OrderListViewModel(coordinator: self)
        let view = OrderListScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
