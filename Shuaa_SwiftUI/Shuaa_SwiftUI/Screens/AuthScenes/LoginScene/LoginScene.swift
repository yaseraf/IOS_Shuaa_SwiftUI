//
//  LoginScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct LoginScene: BaseSceneType {
    @ObservedObject var viewModel: LoginViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            backgroundType: .white,
            contentView: {
                BaseContentView(
                    withScroll:false,
                    backgroundType: .white,
                    content: {
                        LoginContentView(
                            username: $viewModel.username,
                            password: $viewModel.password,
                            onChangeLanguage: {
                                viewModel.changeLanguage()
                            }, onSignUpTap: {
                                SceneDelegate.getAppCoordinator()?.showHomeFlow()
                            }, onVideoTutorialTap: {
                                
                            }
                        )
                        .onViewDidLoad {
                            
                        }
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
    }
}
