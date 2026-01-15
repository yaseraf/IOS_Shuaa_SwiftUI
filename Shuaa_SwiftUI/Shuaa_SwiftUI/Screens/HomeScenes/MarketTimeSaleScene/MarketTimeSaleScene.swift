//
//  TopStocksScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI
import Combine

struct MarketTimeSaleScene: BaseSceneType {
    @ObservedObject var viewModel: MarketTimeSaleViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        MarketTimeSaleContentView(
                            marketsData: $viewModel.marketsData
                        )
                        .onAppear {
                            viewModel.getMarketsData()
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

