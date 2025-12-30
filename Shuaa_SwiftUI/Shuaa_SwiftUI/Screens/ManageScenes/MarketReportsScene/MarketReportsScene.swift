//
//  MarketReportsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation
import SwiftUI
import Combine

struct MarketReportsScene: BaseSceneType {
    @ObservedObject var viewModel: MarketReportsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                MarketReportsContentView(reportsData: $viewModel.reports, onReportTap: { index in
                    viewModel.download(index: index)
                }, onBackTap: {
                    viewModel.popViewController()
                })
                .onAppear {
                    viewModel.callReportsAPI()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            ReportsAPI()
        }
    }
    private func ReportsAPI() {
        viewModel.$reportsListModelAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result {
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
