//
//  AlertsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct AlertsScene: BaseSceneType {
    @ObservedObject var viewModel: AlertsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                AlertsContentView(alertsData: $viewModel.alertsData, onBackTap: {
                    viewModel.onBackTap()
                }, onAddTap: {
                    viewModel.openAddAlertsScene()
                })
                .onAppear {
                    viewModel.getAlertsData()
//                    viewModel.getAllPushNotificationsByUserAPI(success: true)
                    viewModel.getListParameter()
                    viewModel.getAlertsByUserCodeAPI(success: true)
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            alertsAPI()
        }
    }
    
    private func alertsAPI() {
        viewModel.$getAlertsByUserCodeAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
