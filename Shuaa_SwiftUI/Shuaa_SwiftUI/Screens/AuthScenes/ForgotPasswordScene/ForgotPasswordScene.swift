//
//  ForgotPasswordScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ForgotPasswordScene: BaseSceneType {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, content: {
                ForgotPasswordContentView(forgotType: $viewModel.forgotType, nin: "", qid: "", onBack: {
                    viewModel.onBack()
                }, onSubmit: { nin, qID in
                    viewModel.callUserAuthenticateAdvanceAPI(success: true, nin: nin, qID: qID)
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            UserAuthenticateAdvanceAPI()
        }
    }
    private func UserAuthenticateAdvanceAPI() {
        viewModel.$userAuthenticateAdvanceAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
