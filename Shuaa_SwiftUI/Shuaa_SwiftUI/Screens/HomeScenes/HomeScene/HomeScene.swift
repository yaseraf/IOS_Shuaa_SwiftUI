//
//  HomeScene.swift
//  Shuaa_SwiftUI
//
//  Created by Tawfeeq Irshaidat on 23/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct HomeScene: BaseSceneType {
    @ObservedObject var viewModel: HomeViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        HomeContentView(
                            marketsData: $viewModel.marketsData,
                            stocksData: $viewModel.stocksData
                        )
                        .onAppear {
                            viewModel.getMarketsData()
                            viewModel.getStocksData()
                        }
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            
        }
    }
}
