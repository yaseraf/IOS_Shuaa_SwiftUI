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

class HomeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
        openHomeScene()
    }

    func restart() {
        start()
    }
    
    func getHomeCoordinator() -> HomeCoordinator {
        let  coordinator:HomeCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: HomeCoordinator.self) as? HomeCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getAuthCoordinator() -> AuthCoordinator {
        let  coordinator:AuthCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController, startViewType: .login)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getPortfolioCoordinator() -> PortfolioCoordinator {
        let  coordinator:PortfolioCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: PortfolioCoordinator.self) as? PortfolioCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getManageCoordinator() -> ManageCoordinator {
        let  coordinator:ManageCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: ManageCoordinator.self) as? ManageCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getTradeCoordinator() -> TradeCoordinator {
        let  coordinator:TradeCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: TradeCoordinator.self) as? TradeCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getFavoriteCoordinator() -> FavoriteCoordinator {
        let  coordinator:FavoriteCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: FavoriteCoordinator.self) as? FavoriteCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getGenericCoordinator() -> GenericCoordinator {
        let  coordinator:GenericCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: GenericCoordinator.self) as? GenericCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }

}
extension HomeCoordinator:HomeCoordinatorProtocol{

    func openHomeScene() {
        let useCase = HomeUseCase()
        let lookupsUseCase = LookupsUseCase()
        let viewModel = HomeViewModel(coordinator: self, useCase: useCase, lookupsUseCase: lookupsUseCase)
        let view = HomeScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openShareDetailsScene() {
        let useCase = TradeUseCase()
        let homeUsecase = HomeUseCase()
        let viewModel = ShareDetailsViewModel(coordinator: self, useCase: useCase, homeUseCase: homeUsecase)
        let view = ShareDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openNewsDetailsScene(selectedNews: GetAllMarketNewsBySymbolUIModel) {
        let viewModel = NewsDetailsViewModel(coordinator: self, newsData: selectedNews)
        let view = NewsDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium(), .large()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openChartScene(selectedStock: GetCompaniesLookupsUIModel) {
        let viewModel = ChartViewModel(coordinator: self, selectedStock: selectedStock)
        let view = ChartScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openFilterScene(delegate: WatchlistFilterDelegate, categoryFilter: [FilterCategoryModel], specificSharesFilter: SpecificShareTypes, sectorTypeFilter: SectorTypes) {
        let useCase = HomeUseCase()
        let viewModel = FilterViewModel(coordinator: self, useCase: useCase, delegate: delegate, categoryFilter: categoryFilter, specificSharesFilter: specificSharesFilter, sectorFilter: sectorTypeFilter)
        let view = FilterScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium(), .large()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openManageScene() {
        let viewModel = ManageViewModel(coordinator: self)
        let view = ManageScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openSettingScene() {
        let viewModel = SettingViewModel(coordinator: self)
        let view = SettingScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
