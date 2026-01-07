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

class PortfolioCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        self.navigationController.viewControllers = []
        
        AppUtility.shared.screenTransition(navigationController: navigationController, animationOptions: .transitionCrossDissolve, duration: 0.3, animated: false)

        openPortfolioScene()
    }

    func restart() {
        start()
    }
}
extension PortfolioCoordinator:PortfolioCoordinatorProtocol{

    func openPortfolioScene() {
        let useCase = PortfolioUseCase()
        let viewModel = PortfolioViewModel(coordinator: self, useCase: useCase)
        let view = PortfolioScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

}
