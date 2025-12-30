//
//  ChangePasswordScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ChangePasswordScene: BaseSceneType {
    @ObservedObject var viewModel: ChangePasswordViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, content: {
                ChangePasswordContentView(listPasswordValidation: $viewModel.listPasswordValidation, isAllPasswordMatch: $viewModel.isAllPasswordMatch, newPassword: "", confirmNewPassword: "", isNewPasswordHidden: true, isConfirmNewPasswordHidden: true, onBack: {
                    viewModel.onBack()
                }, onConfirmChangePassword: { password in
                    viewModel.onConfirmChangePassword(password: password)
                }, onPasswordChange: { text in
                    viewModel.checkValidation(text: text)
                    withAnimation {
                        viewModel.checkIsAllPasswordMatch()
                    }
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            ResetPasswordAPI()
        }
    }
    private func ResetPasswordAPI() {
        viewModel.$resetPasswordAdvanceAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
