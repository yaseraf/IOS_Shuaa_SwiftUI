//
//  FilterScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct FilterScene: BaseSceneType {
    @ObservedObject var viewModel: FilterViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                FilterContentView(filterCategoryItems: $viewModel.filterCategoryItems, selectedSpecificShareType: $viewModel.selectedSpecificShareType, selectedSectorType: $viewModel.selectedSectorType, onCloseTap: {
                    viewModel.onCloseTap()
                }, onConfirm: {
                    viewModel.onConfirmTap()
                })
            })
        })
        .onAppear {
            viewModel.callGetMarketWatchByProfileIDAPI()
        }
    }
}
