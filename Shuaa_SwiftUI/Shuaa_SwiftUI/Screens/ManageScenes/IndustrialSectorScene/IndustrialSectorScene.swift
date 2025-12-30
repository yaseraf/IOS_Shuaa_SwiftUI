//
//  MarketSummaryScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct IndustrialSectorScene: BaseSceneType {
    @ObservedObject var viewModel: IndustrialSectorViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                IndustrialSectorContentView(chartLoaded: $viewModel.chartLoaded, industrialSectorData: $viewModel.industrialSectorData, onBackTap: {
                    viewModel.onBackTap()
                }, onExploreCompaniesTap: {
                    viewModel.onExploreCompaniesTap()
                })
            })
            .onAppear {
                viewModel.callGetMarketIndiciesAPI(succecss: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetMarketIndiciesAPI()
        }
    }
    private func GetMarketIndiciesAPI() {
        viewModel.$getMarketIndiciesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
