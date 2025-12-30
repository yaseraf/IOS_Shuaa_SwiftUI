//
//  ChartScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ChartScene: BaseSceneType {
    @ObservedObject var viewModel: ChartViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                ChartContentView(selectedStock: $viewModel.selectedStock, chartLoaded: $viewModel.chartLoaded, onBackTap: {
                    viewModel.onBackTap()
                }, onBuyTap: { type in
                    viewModel.openTradeScene(typeOfTrade: type)
                }, onSellTap: { type in
                    viewModel.openTradeScene(typeOfTrade: type)
                })
            })
        })
    }
}
