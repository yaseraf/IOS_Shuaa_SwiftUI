//
//  MarketDealsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct MarketDealsScene: BaseSceneType {
    @ObservedObject var viewModel: MarketDealsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                MarketDealsContentView(marketDealsData: $viewModel.marketDealsData, onBackTap: {
                    viewModel.onBackTap()
                })
            })
            .onAppear{
                viewModel.getMarketDealsData()
                viewModel.GetMarketTimeSaleSignalR()
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
        }
    }
}
