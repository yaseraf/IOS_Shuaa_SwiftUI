//
//  AuthCoordinator.swift
//  Shuaa

import Foundation
import SwiftUI
import FlagAndCountryCode

class AuthCoordinator:  ObservableObject {
    enum AuthStartSceneType{
        case login
        case boarding
        case register
    }
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController
    var startViewType: AuthStartSceneType

    init(navigationController: BaseNavigationController,startViewType:AuthStartSceneType) {
        self.navigationController = navigationController
        self.startViewType = startViewType
    }

    func updateStartViewType(_ type: AuthStartSceneType) {
        self.startViewType = type
    }

    func start() {        
        AppUtility.shared.screenTransition(
            navigationController: navigationController,
            animationOptions: AppConstants.screenTransition,
            duration: AppConstants.screenTransitionDuration,
            animated: AppConstants.isScreenTransitionAnimated
        )
        
        switch startViewType {
        case .login:
            openLoginScene()
        case .boarding:
            openLoginScene()
        case .register:
            openLoginScene()
        }
    }

    func restart() {
        start()
    }
    
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func openLoginScene() {
        let viewModel = LoginViewModel(coordinator: self)
        let view = LoginScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
