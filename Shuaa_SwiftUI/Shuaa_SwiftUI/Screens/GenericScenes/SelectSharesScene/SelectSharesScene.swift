//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct SelectSharesScene: BaseSceneType {
    @ObservedObject var viewModel: SelectSharesViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SelectSharesContentView(sharesDataTelecom: $viewModel.sharesDataTelecom, sharesDataInsurance: $viewModel.sharesDataInsurance, companiesLookupsData: $viewModel.companiesLookups, selectedShare: $viewModel.selectedShare, onConfirm: { share in
                    viewModel.onConfirm(share: share)
                }, onDismiss: {
                    viewModel.onDismiss()
                })
                .onAppear {
                    viewModel.GetCompaniesLookupsAPI(success: true)
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            CompaniesLookupsAPI()
        }

    }
    
    private func CompaniesLookupsAPI() {
        viewModel.$getCompaniesLookupsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
