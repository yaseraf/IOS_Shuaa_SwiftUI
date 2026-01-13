//
//  HomeCoorindator.swift
//  Shuaa

import Foundation
import SwiftUI
import FlagAndCountryCode

class AccountsCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        AppUtility.shared.screenTransition(navigationController: navigationController, animationOptions: .transitionCrossDissolve, duration: 0.3, animated: false)
        openAccountsScene()
    }

    func restart() {
        start()
    }
    
}

extension AccountsCoordinator:AccountsCoordinatorProtocol {

    func openAccountsScene() {
        let viewModel = AccountsViewModel(coordinator: self)
        let view = AccountsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
