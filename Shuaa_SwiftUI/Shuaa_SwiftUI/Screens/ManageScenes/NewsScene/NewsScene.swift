//
//  NewsDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct NewsScene: BaseSceneType {
    @ObservedObject var viewModel: NewsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                NewsContentView(newsData: $viewModel.newsData, onNewsDetailsTap: { selectedNews in
                    viewModel.openNewsDetailsScene(selectedNews: selectedNews)
                }, onBackTap: {
                    viewModel.onBackTap()
                })
                .onAppear {
                    viewModel.getNewsData()
                }
            })
        })
    }
}
