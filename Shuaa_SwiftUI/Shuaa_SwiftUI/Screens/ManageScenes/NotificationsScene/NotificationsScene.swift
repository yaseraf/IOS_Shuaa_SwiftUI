//
//  NotificationsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct NotificationsScene: BaseSceneType {
    @ObservedObject var viewModel: NotificationsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                NotificationsContentView(alertsData: $viewModel.alertsData, onBackTap: {
                    viewModel.onBackTap()
                })
            })
            .onAppear {
                viewModel.callGetAlertByUserCodeAPI()
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            getAlertsAPI()
        }
    }
    
    private func getAlertsAPI() {
        viewModel.$getAlertUserCodeAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
