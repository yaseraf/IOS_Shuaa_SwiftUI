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
                HomeContentView()
                .onAppear {
                    viewModel.getMarketsData()
                    viewModel.getStocksData()
                    if Connection_Hub.shared.isConnected() {

                    } else {
                        Connection_Hub.shared.onConnected = {
                            
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

}
