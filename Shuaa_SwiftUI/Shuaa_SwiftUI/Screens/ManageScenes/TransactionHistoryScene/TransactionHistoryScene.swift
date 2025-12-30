//
//  TransactionDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 07/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct TransactionHistoryScene: BaseSceneType {
    @ObservedObject var viewModel: TransactionHistoryViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                TransactionHistoryContentView(transactionHistory: $viewModel.transactionsHistoryData, userData: $viewModel.userData, onBackTap: {
                    viewModel.onBackTap()
                }, onPortfolioTap: {
                    viewModel.openSelectPortfolioScene()
                }, onDetailsTap: { transactionData in
                    viewModel.openTransactionDetailsScene(transactionData: transactionData)
                })
            })
            .onAppear {
                viewModel.callGetB2bRequestsModel(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            GetB2bRequestsAPI()
            GetShareTransferLogWithDetailsAPI()
        }
    }
    
    private func GetB2bRequestsAPI() {
        viewModel.$GetB2bRequestsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func GetShareTransferLogWithDetailsAPI() {
        viewModel.$GetShareTransferLogWithDetailsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
