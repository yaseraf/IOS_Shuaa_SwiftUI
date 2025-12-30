//
//  BalanceDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct BalanceDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: BalanceDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                BalanceDetailsContentView(userData: $viewModel.userData, portfolioData: $viewModel.portfolioData, onBackTap: {
                    viewModel.onBackTap()
                }, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                })
            })
            .onAppear {
                viewModel.getUserData()
                viewModel.callGetPortfolioAPI(success: true)
            }
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
