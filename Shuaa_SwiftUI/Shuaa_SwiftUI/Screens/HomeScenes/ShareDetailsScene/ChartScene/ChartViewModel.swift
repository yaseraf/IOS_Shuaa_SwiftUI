//
//  ChartViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation

class ChartViewModel: ObservableObject {
    private var coordinator: HomeCoordinatorProtocol
    
    @Published var selectedStock: GetCompaniesLookupsUIModel?
    @Published var chartLoaded: Bool?
    
    init(coordinator: HomeCoordinatorProtocol, selectedStock: GetCompaniesLookupsUIModel?) {
        self.coordinator = coordinator
        self.selectedStock = selectedStock
        
        chartLoaded = false
    }
}


// MARK: Routing
extension ChartViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openTradeScene(typeOfTrade: TypeOfTrade) {
        
        let stock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first ?? .testUIModel()
        UserDefaultController().selectedSymbolType = stock.marketType
        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().openTradeScene(stock: stock, typeOfTrade: typeOfTrade, orderDetails: .initializer())
    }
}
