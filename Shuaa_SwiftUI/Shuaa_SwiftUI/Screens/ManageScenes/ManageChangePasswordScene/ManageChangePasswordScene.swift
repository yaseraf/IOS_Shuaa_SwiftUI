//
//  ChangePasswordScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ManageChangePasswordScene: BaseSceneType {
    @ObservedObject var viewModel: ManageChangePasswordViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, content: {
                ManageChangePasswordContentView(listPasswordValidation: $viewModel.listPasswordValidation, isAllPasswordMatch: $viewModel.isAllPasswordMatch, newPassword: "", confirmNewPassword: "", isNewPasswordHidden: true, isConfirmNewPasswordHidden: true, onBack: {
                    viewModel.onBack()
                }, onConfirmChangePassword: { oldPassword, password in
                    viewModel.onConfirmChangePassword(oldPassword: oldPassword, password: password)
                }, onPasswordChange: { text in
                    viewModel.checkValidation(text: text)
                    withAnimation {
                        viewModel.checkIsAllPasswordMatch()
                    }
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            ChangesPasswordAPI()
        }
    }
    private func ChangesPasswordAPI() {
        viewModel.$changesPasswordAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
