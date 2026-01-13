//
//  PortfolioScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation
import SwiftUI
import Combine

struct PortfolioScene: BaseSceneType {
    @ObservedObject var viewModel: PortfolioViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        PortfolioContentView(
                            userAccountsData: $viewModel.userAccountsData,
                            portfolioData: $viewModel.portfolioData
                        )
                        .onAppear {
                            viewModel.getUserAccountsData()
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
