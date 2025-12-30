//
//  ListOfCompaniesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct ListOfCompaniesScene: BaseSceneType {
    @ObservedObject var viewModel: ListOfCompaniesViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                ListOfCompaniesContentView(companiesLookupsData: $viewModel.companiesLookups, favoriteList: $viewModel.favoriteWatchlist, selectedShare: $viewModel.selectedShare, onDismiss: {
                    viewModel.onBackTap()
                }, onHeartTap: { symbol in
                    viewModel.stockFavorite(symbol: symbol)
                })
            })
            .onAppear {
                viewModel.GetCompaniesLookupsAPI(success: true)
                viewModel.initialGetAllProfilesLookupsByUserCodeAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            CompaniesLookupsAPI()
            GetAllProfilesLookupsByUserCodeAPI()
            GetMarketWatchByProfileIDAPI()
            AddMarketWatchProfileNameAPI()
            AddMarketWatchProfileSymbolsAPI()
            DeleteMarketWatchProfileSymbolsAPI()
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
