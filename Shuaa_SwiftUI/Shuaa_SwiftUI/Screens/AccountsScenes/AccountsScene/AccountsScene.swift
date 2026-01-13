//
//  OrderListScene.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation
import SwiftUI
import Combine

struct AccountsScene: BaseSceneType {
    @ObservedObject var viewModel: AccountsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    content: {
                        AccountsContentView(
                            userAccountsData: $viewModel.userAccountsData
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
