//
//  CashInScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct SharesTransferScene: BaseSceneType {
    @ObservedObject var viewModel: SharesTransferViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SharesTransferContentView(userData: $viewModel.userData, selectedShare: $viewModel.selectedShare, transactionAmount: $viewModel.transactionAmount, availableShares: $viewModel.availableShares, cost: $viewModel.cost, selectedTypeOfTransaction: $viewModel.selectedTypeOfTransaction, onBackTap: {
                    viewModel.onBackTap()
                }, onSendTap: {
                    if Double(viewModel.transactionAmount) ?? 0 > 0 && Double(viewModel.transactionAmount) ?? 0 <= $viewModel.availableShares.wrappedValue {
                        viewModel.callSubmitShareTransferReqAPI(success: true)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "please_enter_a_valid_amount".localized)
                    }
                }, onSelectSharesTap: {
                    viewModel.openSelectSharesScene()
                }, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                })
            })
            .onAppear {

            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            SubmitShareTransferReqAPI()
            GetExpectedProfitLossAPI()
        }
    }
    
    private func SubmitShareTransferReqAPI() {
        viewModel.$SubmitShareTransferReqAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func GetExpectedProfitLossAPI() {
        viewModel.$GetExpectedProfitLossSecAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
