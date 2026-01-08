//
//  SplashScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import SwiftUI
import Combine

struct SplashScene: BaseSceneType {
    @ObservedObject var viewModel: SplashViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()

    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        SplashContentView(
                            onVideoEnd: {
                                viewModel.openLoginScene()
                            }
                        )
                    }
                )
            }, showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {

        }
    }
}
