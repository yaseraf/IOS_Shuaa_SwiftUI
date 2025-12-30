//
//  AppRatingScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 10/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct AppRatingScene: BaseSceneType {
    @ObservedObject var viewModel: AppRatingViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                AppRatingContentView(onBackTap: {
                    viewModel.onBackTap()
                }, onSendTap: {
                    viewModel.onSendTap()
                })
            })
        })
    }
}
