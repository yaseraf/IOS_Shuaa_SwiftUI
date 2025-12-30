//
//  OrderDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 08/10/2025.
//

import Foundation
import SwiftUI
import Combine

struct OrderDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: OrderDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                OrderDetailsContentView(orderDetails: $viewModel.orderDetails, onEditTap: {
                    viewModel.editOrder()
                }, onCancelTap: {
                    viewModel.cancelOrder()
                }, onDismiss: {
                    viewModel.dismiss()
                })
                .onAppear {
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
//            CompaniesLookupsAPI()
//            ordersAPI()
        }
    }

//    private func CompaniesLookupsAPI() {
//        viewModel.$getCompaniesLookupsAPIResult.receive(on: DispatchQueue.main).sink { result  in
//            switch result{
//            case .onFailure(let error):
//                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
//            case.onLoading(let show):
//                viewTypeAction.showLoading = show
//            case.onSuccess(let data):
//                debugPrint("")
//            case .none:
//                break
//            }
//        }.store(in: &anyCancellable)
//    }
}
