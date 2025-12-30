//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct TradeConfirmationScene: BaseSceneType {
    @ObservedObject var viewModel: TradeConfirmationViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                TradeConfirmationContentView(shares: $viewModel.shares, price: $viewModel.price, value: $viewModel.value, expiryDate: $viewModel.expiryDate, selectedTypeOfTrade: $viewModel.selectedTypeOfTrade, onEditTap: {
                    viewModel.onEditTap()
                }, onDismiss: {
                    viewModel.onDismiss()
                }, onSendTap: {
                    viewModel.onSendTap()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            OrderAPI()
        }
    }
    private func OrderAPI() {
        viewModel.$sendOrdersAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
