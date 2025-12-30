//
//  OrderListScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 11/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct TradeScene: BaseSceneType {
    @ObservedObject var viewModel: TradeViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {

        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                TradeContentView(userData: $viewModel.userData, riskManagementData: $viewModel.riskManagementData, selectedStock: $viewModel.selectedStock, marketWatchData: $viewModel.marketWatchData, selectedTypeOfTrade: $viewModel.typeOfTrade, appearAmount: $viewModel.appearAmount, price: $viewModel.price, sharesAmount: $viewModel.shares, flagMessage: $viewModel.flagMessage, tillCancelToggle: $viewModel.tillCancelToggle, marketPriceToggle: $viewModel.marketPriceToggle, onTypeOfTradeChange: { typeOfTrade in
                    viewModel.onTypeOfTradeChange(typeOfTrade: typeOfTrade)
                }, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                }, onQuantityCalculatorTap: {
                    viewModel.openQuantityCalculatorScene()
                }, onAppearChange: {
                    viewModel.onAppearChange()
                }, onPriceChange: {
                    viewModel.onPriceChange()
                }, onSharesChange: {
                    viewModel.onSharesChange()
                }, onTillCancelToggle: {
                    viewModel.onTillCancelToggle()
                }, onMarketPriceToggle: {
                    viewModel.onMarketPriceToggle()
                }, onSendTap: {
                    viewModel.onSendTap()
                }, onSearchTap: {
                    viewModel.openSelectSharesScene()
                }, onBackTap: {
                    viewModel.onBackTap()
                })
                .onAppear {
                    viewModel.callGetAllMarketWatchBySymbolAPI()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            getMarketWatchAPI()
        }
    }
    
    private func getMarketWatchAPI() {
        viewModel.$getAllMarketWatchBySymbolAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
