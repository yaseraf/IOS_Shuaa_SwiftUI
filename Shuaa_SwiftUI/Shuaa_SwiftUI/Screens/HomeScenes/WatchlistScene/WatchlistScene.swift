//
//  WatchlistScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI
import Combine

struct WatchlistScene: BaseSceneType {
    @ObservedObject var viewModel: WatchlistViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        WatchlistContentView(
                            marketsData: $viewModel.marketsData
                        )
                        .onAppear {

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

