//
//  AppCoordinator.swift
//  Shuaa

import Foundation
import SwiftUI

class AppCoordinator:  ObservableObject {

    var navigationController: BaseNavigationController
    var childCoordinator: [Coordinator] = []
    private let window: UIWindow

    var currentAuthCoordinator:AuthCoordinator? {
        get {
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator
        }
    }
    
    var currentHomeCoordinator:HomeCoordinator? {
        get {
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: HomeCoordinator.self) as? HomeCoordinator
        }
    }
    
    var currentOrderListCoordinator:OrderListCoordinator? {
        get {
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: OrderListCoordinator.self) as? OrderListCoordinator
        }
    }
    
    var currentTradeCoordinator:TradeCoordinator? {
        get {
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: TradeCoordinator.self) as? TradeCoordinator
        }
    }
    
    var currentAccountsCoordinator:OrderListCoordinator? {
        get {
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: OrderListCoordinator.self) as? OrderListCoordinator
        }
    }
    
    var currentPortfolioCoordinator:PortfolioCoordinator? {
        get {
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: PortfolioCoordinator.self) as? PortfolioCoordinator
        }
    }

    init(window: UIWindow) {
        self.window = window
        navigationController = BaseNavigationController()
        self.window.rootViewController = navigationController
    }

    func start() {
        SceneDelegate.getAppCoordinator()?.updateWindowBackground()
        openSplashScene()
    }

    func logout(){
        // clear data
        childCoordinator.removeAll()
        
        AppUtility.shared.screenTransition(
            navigationController: navigationController,
            animationOptions: AppConstants.screenTransition,
            duration: AppConstants.screenTransitionDuration,
            animated: AppConstants.isScreenTransitionAnimated
        )
        
        startFlow(startWith: .login)

    }

    func getWindow() -> UIWindow {
        return window
    }


    func updateWindowBackground() {
        window.backgroundColor = UIColor(Color.colorBackground)
    }

    func showViewWithAnimation(dvc: UIViewController) {
        window.rootViewController = dvc
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.4
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: { _ in
        })
    }

    func restart() {
        childCoordinator.last?.start()
        
        AppUtility.shared.screenTransition(
            navigationController: navigationController,
            animationOptions: AppConstants.screenTransition,
            duration: AppConstants.screenTransitionDuration,
            animated: AppConstants.isScreenTransitionAnimated
        )
    }
    
    func restartForTheme() {
        SceneDelegate.getAppCoordinator()?.topViewController()?.dismiss(animated: false, completion: nil)
        childCoordinator.last?.start()
        
        AppUtility.shared.screenTransition(
            navigationController: navigationController,
            animationOptions: AppConstants.screenTransition,
            duration: AppConstants.screenTransitionDuration,
            animated: AppConstants.isScreenTransitionAnimated
        )
    }

    var isUserLoggedIn:Bool {
        get{
            let  childCoordinator = self.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator
            return childCoordinator == nil
        }
    }

    func topViewController() -> UIViewController?{
        guard let viewController = self.navigationController.viewControllers.last else{return nil}

        guard let presentedViewController = viewController.presentedViewController else{
            return tabBarChildViewController(currentViewController: viewController)
        }
        return tabBarChildViewController(currentViewController: presentedViewController) 


        func tabBarChildViewController(currentViewController:UIViewController)->UIViewController?{
            if let viewController = currentViewController.presentedViewController{
                if let   viewController =  viewController.presentedViewController{
                    return viewController
                }
                return viewController

            }

            return currentViewController
        }
    }

    public func showMessage(type: MessageViewType = .success, _ message: String) {
        MessageViewController.instance.show(type, text: message)
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func startFlow(startWith: AuthCoordinator.AuthStartSceneType) {
        let authCoordinator:AuthCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator {
            authCoordinator = childCoordinator
            authCoordinator.updateStartViewType(startWith)
        } else {
            childCoordinator.removeAll()
            authCoordinator =  .init(navigationController: navigationController, startViewType: startWith)
            childCoordinator.append(authCoordinator)
            authCoordinator.updateStartViewType(startWith)
        }
        authCoordinator.start()
    }
    
    func showHomeFlow() {
        removeAllChildCoordinator()

        let homeCoordinator:HomeCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: HomeCoordinator.self) as? HomeCoordinator {
            homeCoordinator = childCoordinator
        } else {
            childCoordinator.removeAll()
            homeCoordinator =  .init(navigationController: navigationController)
            childCoordinator.append(homeCoordinator)
        }
        homeCoordinator.start()
    }
    
    func showOrderListFlow() {
        removeAllChildCoordinator()

        let orderListCoordinator:OrderListCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: OrderListCoordinator.self) as? OrderListCoordinator {
            orderListCoordinator = childCoordinator
        } else {
            childCoordinator.removeAll()
            orderListCoordinator =  .init(navigationController: navigationController)
            childCoordinator.append(orderListCoordinator)
        }
        orderListCoordinator.start()
    }
    
    func showTradeFlow() {
        removeAllChildCoordinator()

        let tradeCoordinator:TradeCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: TradeCoordinator.self) as? TradeCoordinator {
            tradeCoordinator = childCoordinator
        } else {
            childCoordinator.removeAll()
            tradeCoordinator =  .init(navigationController: navigationController)
            childCoordinator.append(tradeCoordinator)
        }
        tradeCoordinator.start()
    }
    
    func showAccountsFlow() {
        removeAllChildCoordinator()

        let accountsCoordinator:AccountsCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: AccountsCoordinator.self) as? AccountsCoordinator {
            accountsCoordinator = childCoordinator
        } else {
            childCoordinator.removeAll()
            accountsCoordinator =  .init(navigationController: navigationController)
            childCoordinator.append(accountsCoordinator)
        }
        accountsCoordinator.start()
    }
    
    func showPortfolioFlow() {
        removeAllChildCoordinator()

        let portfolioCoordinator:PortfolioCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: PortfolioCoordinator.self) as? PortfolioCoordinator {
            portfolioCoordinator = childCoordinator
        } else {
            childCoordinator.removeAll()
            portfolioCoordinator =  .init(navigationController: navigationController)
            childCoordinator.append(portfolioCoordinator)
        }
        portfolioCoordinator.start()
    }

    func removeAllChildCoordinator(){
        for coordinator in self.childCoordinator {
            for childCoordinator in coordinator.childCoordinator {
                childCoordinator.childCoordinator = []
            }
            coordinator.childCoordinator = []
        }
        childCoordinator = []
    }
    
    func openSplashScene() {
        let viewModel = SplashViewModel(coordinator: self)
        let view =  SplashScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: ============================ Side Menu ============================
    
    func openAccountInformationScene() {
        let viewModel = AccountInformationViewModel(coordinator: self)
        let view = AccountInformationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMyDocumentsScene() {
        let viewModel = MyDocumentsViewModel(coordinator: self)
        let view = MyDocumentsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMarketsInsightScene() {
        let viewModel = MarketsInsightViewModel(coordinator: self)
        let view = MarketsInsightScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openAlertsScene() {
        let viewModel = AddAlertsViewModel(coordinator: self)
        let view = AddAlertsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openAddAlertsScene() {
        let viewModel = AddAlertsViewModel(coordinator: self)
        let view = AddAlertsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openAccountStatementsScene() {
        let viewModel = AccountStatementsViewModel(coordinator: self)
        let view = AccountStatementsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openCashDepositScene() {
        let viewModel = CashDepositViewModel(coordinator: self)
        let view = CashDepositScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openEquityTransferScene() {
        let viewModel = EquityTransferViewModel(coordinator: self)
        let view = EquityTransferScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTransfersScene() {
        let viewModel = TransfersViewModel(coordinator: self)
        let view = TransfersScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMyAccountScene() {
        let viewModel = MyAccountViewModel(coordinator: self)
        let view = MyAccountScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openIPOScene() {
        let viewModel = IPOViewModel(coordinator: self)
        let view = IPOScene(viewModel: viewModel)
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

}
