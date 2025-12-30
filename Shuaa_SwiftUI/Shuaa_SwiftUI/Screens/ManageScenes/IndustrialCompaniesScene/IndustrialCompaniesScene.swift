//
//  MarketSummaryScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct IndustrialCompaniesScene: BaseSceneType {
    @ObservedObject var viewModel: IndustrialCompaniesViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                IndustrialCompaniesContentView(industrialCompaniesData: $viewModel.industrialCompaniesData, onBackTap: {
                    viewModel.onBackTap()
                }, onCompanyTap: {
                    viewModel.onCompanySelect()
                })
                .onAppear {
//                    viewModel.getCompaniesData()
                    viewModel.callGetMarketWatchBySectorIDAPI(succecss: true)
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            MarketWatchBySectorIDAPI()
        }
    }
    
    private func MarketWatchBySectorIDAPI() {
        viewModel.$getMarketWatchBySectorIDAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
