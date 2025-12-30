//
//  FavouriteScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct FavoriteScene: BaseSceneType {
    @ObservedObject var viewModel: FavoriteViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                FavoriteContentView(marketWatchData: $viewModel.marketWatchData, exchangeSummaryData: $viewModel.exchangeSummaryData, topGainerData: $viewModel.topGainerData, topLoserData: $viewModel.topLoserData, mostActiveData: $viewModel.mostActiveData, categoryFilter: $viewModel.categoryFilter, sectorTypeFilter: $viewModel.sectorTypeFilter, specificShareFilter: $viewModel.specificShareFilter, updatedSymbol: $viewModel.updatedSymbol, onStockTap: { selectedStock in
                    viewModel.openShareDetails(selectedStock: selectedStock)
                }, onFilterTap: {
                    viewModel.openFilterScene()
                }, onAlertsTap: {
                    viewModel.openAlertsScene()
                })
                .onAppear {
                    viewModel.callGetAllProfilesLookupsByUserCodeAPI()
                    viewModel.callExchangeSummaryAPI()
                }
                .onDisappear {
                    viewModel.UnSubscribleMarketWatchSymbolsSignalR()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetAllProfilesLookupsByUSerCodeAPI()
            GetMarketWatchByProfileIDAPI()
            SubscribleMarketWatchSymbolsAPI()
        }
    }
    
    private func GetAllProfilesLookupsByUSerCodeAPI() {
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
    
    private func SubscribleMarketWatchSymbolsAPI() {
        viewModel.$subscribleMarketWatchSymbolsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
