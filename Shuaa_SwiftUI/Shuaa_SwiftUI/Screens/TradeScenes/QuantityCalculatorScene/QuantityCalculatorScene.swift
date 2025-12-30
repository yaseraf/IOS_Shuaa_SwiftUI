//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct QuantityCalculatorScene: BaseSceneType {
    @ObservedObject var viewModel: QuantityCalculatorViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                QuantityCalculatorContentView(lastTradePrice: $viewModel.lastTradePrice, calculatedShares: $viewModel.calculatedShares, onCalculate: { amount in
                    viewModel.onCalculate(amount: amount)
                }, onDismiss: {
                    viewModel.onDismiss()
                })
                .onAppear {

                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            CalculatesSharesAPI()
        }
    }
    
    private func CalculatesSharesAPI() {
        viewModel.$calculateSharesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
