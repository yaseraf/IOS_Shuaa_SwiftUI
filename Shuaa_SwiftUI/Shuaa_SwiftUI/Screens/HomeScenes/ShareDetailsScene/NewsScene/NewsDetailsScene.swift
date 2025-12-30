//
//  NewsDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct NewsDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: NewsDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                NewsDetailsContentView(newsData: $viewModel.newsData, onDismiss: {
                    viewModel.onDismiss()
                })
            })
        })
    }
}
