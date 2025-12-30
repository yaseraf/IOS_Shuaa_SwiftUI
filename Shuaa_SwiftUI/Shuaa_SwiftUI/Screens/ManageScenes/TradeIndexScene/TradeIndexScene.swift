//
//  TradeIndexScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct TradeIndexScene: BaseSceneType {
    @ObservedObject var viewModel: TradeIndexViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                TradeIndexContentView(chartLoaded: $viewModel.chartLoaded, exchangeSummaryData: $viewModel.exchangeSummaryData, lastUpdateTime: $viewModel.lastUpdateTime, onBackTap: {
                    viewModel.onBackTap()
                })
            }).onAppear {
                viewModel.callExchangeSummaryAPI()
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetExchangeSummaryAPI()
        }
    }
    private func GetExchangeSummaryAPI() {
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

}
