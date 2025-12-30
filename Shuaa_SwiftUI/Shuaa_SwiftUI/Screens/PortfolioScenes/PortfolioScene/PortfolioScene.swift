//
//  PortfolioScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct PortfolioScene: BaseSceneType {
    @ObservedObject var viewModel: PortfolioViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                PortfolioContentView(userData: $viewModel.userData, portfolioData: $viewModel.portfolioData, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                }, onSellTap: { symbol in
                    viewModel.openTradeScene(symbol: symbol)
                }, onStockTap: { symbol in
                    viewModel.openShareDetails(symbol: symbol)
                })
                .onAppear {
                    viewModel.getUserData()
                    viewModel.callGetUserAccountsAPI(success: true)
//                        viewModel.GetPortfolioSignalR()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetPortfolioAPI()
        }
    }
    
    private func GetPortfolioAPI() {
        viewModel.$getPortfolioAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
