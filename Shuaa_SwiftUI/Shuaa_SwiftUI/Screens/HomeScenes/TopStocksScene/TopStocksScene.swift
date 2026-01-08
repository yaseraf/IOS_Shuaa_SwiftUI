//
//  TopStocksScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI
import Combine

struct TopStocksScene: BaseSceneType {
    @ObservedObject var viewModel: TopStocksViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        TopStocksContentView(
                            marketsData: $viewModel.marketsData,
                            topGainersData: $viewModel.topGainersData,
                            topLosersData: $viewModel.topLosersData,
                            topTurnoverData: $viewModel.topTurnoverData,
                            topVolumeData: $viewModel.topVolumeData,
                            topTradesData: $viewModel.topTradesData
                        )
                        .onAppear {
                            viewModel.getMarketsData()
                            viewModel.getTopStocksData()
                        }
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            
        }
    }
    
    // MARK: Binding

}

