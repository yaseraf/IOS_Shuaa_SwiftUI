//
//  CashInScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct MyAccountsScene: BaseSceneType {
    @ObservedObject var viewModel: MyAccountsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                MyAccountsContentView(selectedCountry: $viewModel.selectedCountry, selectedBank: $viewModel.selectedBank, myAccounts: $viewModel.myAccounts, onBackTap: {
                    viewModel.onBackTap()
                }, onSendTap: {
                    viewModel.onSendRequest()
                }, onBankAccountTap: {
                    viewModel.openSelectBankScene()
                }, onCountryTap: {
                    viewModel.openSelectBankScene()
                }, onUploadFileTap: {
//                    viewModel.openSelectBankScene()
                })
                .onAppear {
                    viewModel.getMyAccountsData()
                }
            })
        })
    }
}
