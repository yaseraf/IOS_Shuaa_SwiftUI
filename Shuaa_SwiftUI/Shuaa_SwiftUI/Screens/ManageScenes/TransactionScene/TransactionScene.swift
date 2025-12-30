//
//  TransactionScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct TransactionScene: BaseSceneType {
    @ObservedObject var viewModel: TransactionsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                TransactionsContentView(onBackTap: {
                    viewModel.onBackTap()
                }, onHistoryTap: {
                    viewModel.openTransactionsHistoryScene()
                }, onCashInTap: {
                    viewModel.openCashInScene()
                }, onCashOutTap: {
                    viewModel.openCashOutScene()
                }, onSharesTransferTap: {
                    viewModel.openSharesTransferScene()
                }, onMyAccountsTap: {
                    viewModel.openMyAccountsScene()
                })
            })
        })
    }
}
