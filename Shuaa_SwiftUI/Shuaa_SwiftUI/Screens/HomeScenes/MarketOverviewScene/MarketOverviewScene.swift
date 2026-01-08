//
//  MarketOverviewScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI
import Combine

struct MarketOverviewScene: BaseSceneType {
    @ObservedObject var viewModel: MarketOverviewViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        MarketOverviewContentView(
                            marketsData: $viewModel.marketsData,
                            indicesData: $viewModel.indicesData
                        )
                        .onAppear {
                            viewModel.getMarketsData()
                            viewModel.getMarketOverviewData()
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
