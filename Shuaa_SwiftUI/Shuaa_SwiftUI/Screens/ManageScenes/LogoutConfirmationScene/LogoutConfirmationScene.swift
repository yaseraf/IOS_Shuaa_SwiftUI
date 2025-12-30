//
//  LogoutConfirmationScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/10/2025.
//

import Foundation
import SwiftUI
import Combine

struct LogoutConfirmationScene: BaseSceneType {
    @ObservedObject var viewModel: LogoutConfirmationViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false,paddingValue:0,paddingVerticalValue: 0, backgroundType: .clear,content: {
                LogoutConfirmaitonContentView(onDoneTap: {
                    viewModel.UsersLogOffAPI(success: true)
                }, onCancelTap: {
                    viewModel.dismiss()
                }, onCloseTap: {
                    viewModel.dismiss()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .background(Color.clear)
        .ignoresSafeArea()
        .onViewDidLoad {
            UsersLogOffAPI()
        }
    }
    private func UsersLogOffAPI() {
        viewModel.$usersLogOffAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
