//
//  ShareDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ShareDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: ShareDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                ShareDetailsContentView(stockDetails: $viewModel.stockDetailsData, depthByPriceData: $viewModel.depthByPriceData, depthByOrderData: $viewModel.depthByOrderData, wholeShareTradesData: $viewModel.wholeShareTradesData, shareTradesSummaryData: $viewModel.shareTradesSummaryData, newsData: $viewModel.newsData, marketNewsBySymbol: $viewModel.marketNewsBySymbol, favoriteList: $viewModel.favoriteWatchlist, onNewsDetailsTap: { data in
                    viewModel.openNewsDetailsScene(data: data)
                }, onBackTap: {
                    viewModel.onBackTap()
                }, onChartTap: {
                    viewModel.openChartScene()
                }, onBuyTap: { typeOfTrade in
                    if UserDefaultController().isPreviewMode == true {
                        viewModel.openLoginScene()
                    } else {
                        viewModel.openTradeScene(typeOfTrade: typeOfTrade)
                    }
                },onSellTap: { typeOfTrade in
                    if UserDefaultController().isPreviewMode == true {
                        viewModel.openLoginScene()
                    } else {
                        viewModel.openTradeScene(typeOfTrade: typeOfTrade)
                    }
                }, onHeartTap: { symbol in
                    if UserDefaultController().isPreviewMode == true {
                        viewModel.openLoginScene()
                    } else {
                        viewModel.stockFavorite(symbol: symbol)
                    }
                })
                .onAppear {
                    viewModel.getMarketDepthData()
                    viewModel.getWholeShareTradesData()
                    viewModel.getShareTradesSummaryData()
                    viewModel.getNewsData()
                    viewModel.GetAllMarketWatchBySymbolAPI(success: true)
                    viewModel.subscribeFullMDSymbols()
                    viewModel.SendSymbolTradesSummaryObject()
//                    viewModel.getSymbolTradesFullObject()
                    viewModel.GetAllMarketNewsBySymbol(success: true)
                    viewModel.initialGetAllProfilesLookupsByUserCodeAPI(success: true)
                }
                .onReceive(timer) { _ in
                    viewModel.getSymbolTradesFullObject()
                }
                .onDisappear {
//                    viewModel.unSubscribeFullMDSymbols()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetMarketWatchAPI()
            GetAllProfilesLookupsByUserCodeAPI()
            GetMarketWatchByProfileIDAPI()
            AddMarketWatchProfileNameAPI()
            AddMarketWatchProfileSymbolsAPI()
            DeleteMarketWatchProfileSymbolsAPI()
        }
    }
    
    private func GetMarketWatchAPI() {
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
    
    private func GetAllProfilesLookupsByUserCodeAPI() {
        viewModel.$getAllProfilesLookupsByUserCodeAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func GetMarketWatchByProfileIDAPI() {
        viewModel.$getMarketWatchByProfileIDAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
       
    private func AddMarketWatchProfileNameAPI() {
        viewModel.$addMarketWatchProfileNameAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func AddMarketWatchProfileSymbolsAPI() {
        viewModel.$AddMarketWatchProfileSymbolsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func DeleteMarketWatchProfileSymbolsAPI() {
        viewModel.$DeleteMarketWatchProfileSymbolsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
