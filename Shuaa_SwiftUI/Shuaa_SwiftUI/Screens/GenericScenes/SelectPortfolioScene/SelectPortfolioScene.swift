//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct SelectPortfolioScene: BaseSceneType {
    @ObservedObject var viewModel: SelectPortfolioViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SelectPortfolioContentView(usersData: $viewModel.usersData, selectedUser: $viewModel.selectedUser, onConfirm: { user in
                    viewModel.onConfirm(user: user)
                }, onDismiss: {
                    viewModel.onDismiss()
                })
                .onAppear {
                    viewModel.callGetUserAccountsAPI()
                }
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            getUserAccountsAPI()
        } 
    }
    
    private func getUserAccountsAPI() {
        viewModel.$getUserAccountsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
