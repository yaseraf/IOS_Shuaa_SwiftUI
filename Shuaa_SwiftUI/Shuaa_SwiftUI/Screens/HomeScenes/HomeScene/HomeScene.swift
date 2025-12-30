//
//  HomeScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct HomeScene: BaseSceneType {
    @ObservedObject var viewModel: HomeViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                HomeContentView(marketWatchData: $viewModel.marketWatchData, exchangeSummaryData: $viewModel.exchangeSummaryData, topGainerData: $viewModel.topGainerData, topLoserData: $viewModel.topLoserData, mostActiveData: $viewModel.mostActiveData, categoryFilter: $viewModel.categoryFilter, sectorTypeFilter: $viewModel.sectorTypeFilter, specificShareFilter: $viewModel.specificShareFilter, updateTrigger: $viewModel.updateTrigger, updatedSymbol: $viewModel.updatedSymbol, onStockTap: { selectedStock in
                    viewModel.openShareDetails(selectedStock: selectedStock)
                }, onFilterTap: {
                    viewModel.openFilterScene()
                }, onAlertsTap: {
                    if UserDefaultController().isPreviewMode == true {
                        viewModel.openLoginScene()
                    } else {
                        viewModel.openAlertsScene()
                    }
                })
                .onAppear {
                    if Connection_Hub.shared.isConnected() {
                        viewModel.GetCompaniesLookupsAPI(success: true, searchSymbol: "")
                        viewModel.callGetAllProfilesLookupsByUserCodeAPI()
                        viewModel.callExchangeSummaryAPI()
                        viewModel.callGetUserAccountsAPI()
                        viewModel.resetData()
                        viewModel.connectDelegates()

                    } else {
                        Connection_Hub.shared.onConnected = {
                            viewModel.connectionHubAPIResult = .onLoading(show: false)
                            viewModel.GetCompaniesLookupsAPI(success: true, searchSymbol: "")
                            viewModel.callGetAllProfilesLookupsByUserCodeAPI()
                            viewModel.callExchangeSummaryAPI()
                            viewModel.callGetUserAccountsAPI()
                            viewModel.resetData()
                            viewModel.connectDelegates()
                        }
                    }
                }
                .onDisappear {
//                    viewModel.UnSubscribleMarketWatchSymbolsSignalR()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            connectionHub()
//            getAllProfilesLookupsByUserCodeAPI()
//            getMarketWatchByProfileIDAPI()
            getExchangeSummaryAPI()
//            getUserAccountsAPI()
            companiesLookupsAPI()
        }
    }
    
    private func connectionHub() {
        viewModel.$connectionHubAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func companiesLookupsAPI() {
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
    
    private func getExchangeSummaryAPI() {
        viewModel.$getExchangeSummaryAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getUserAccountsAPI() {
        viewModel.$getUserAccountsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getAllProfilesLookupsByUserCodeAPI() {
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
    
    private func getMarketWatchByProfileIDAPI() {
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


}
