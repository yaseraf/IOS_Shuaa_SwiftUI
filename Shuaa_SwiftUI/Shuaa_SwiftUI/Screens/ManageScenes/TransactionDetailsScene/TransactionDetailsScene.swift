//
//  TransactionDetailsScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 07/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct TransactionDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: TransactionDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                TransactionDetailsContentView(transactionAmount: $viewModel.transactionAmount, fromAccount: $viewModel.fromAccount, status: $viewModel.status, statusDesc: $viewModel.statusDesc, transactionType: $viewModel.transactionType, transactionDate: $viewModel.transactionDate, onBackTap: {
                    viewModel.onBackTap()
                })
            })
        })
    }
}
