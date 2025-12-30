//
//  OrderListScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 11/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct OrderListScene: BaseSceneType {
    @ObservedObject var viewModel: OrderListViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                OrderListContentView(userData: $viewModel.userData, orderListData: $viewModel.orderListData, filteredSymbol: $viewModel.filteredSymbol, filteredOSSList: $viewModel.filterOSSList, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                }, onStockTap: { stock, typeOfTrade in
//                    viewModel.openTradeScene(stock: stock, typeOfTrade: typeOfTrade)
                    viewModel.openOrderDetailsScene(orderDetails: stock)
                }, onBackTap: {
                    viewModel.onBackTap()
                }, onSearchTap: {
                    viewModel.openSelectSharesScene(typeOfTrade: .buy, isTrading: false)
                }, onResetTap: {
                    viewModel.onResetTap()
                }, onBuyTap: { typeOfTrade in
                    viewModel.openSelectSharesScene(typeOfTrade: typeOfTrade, isTrading: true)
                }, onSellTap: { typeOfTrade in
                    viewModel.openSelectSharesScene(typeOfTrade: typeOfTrade, isTrading: true)
                })
                .onAppear {
                    viewModel.getUserData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.sendOrdersSignalR()
                    }
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
//            CompaniesLookupsAPI()
            ordersAPI()
        }
    }

    private func CompaniesLookupsAPI() {
        viewModel.$getCompaniesLookupsAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let data):
                debugPrint("")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }
    
    private func ordersAPI() {
        viewModel.$sendOrdersAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let data):
                debugPrint("")
            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }

}
