//
//  ManageScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ManageScene: BaseSceneType {
    @ObservedObject var viewModel: ManageViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                ManageContentView(onSettingTap: {
                    viewModel.openSettingScene()
                }, onContactUsTap: {
                    viewModel.openContactUsScene()
                }, onAppRatingTap: {
                    viewModel.openAppRatingScene()
                }, onLogoutTap: {
                    viewModel.openLogoutConfirmationScene()
                }, onSharesTransferTap: {
                    viewModel.openTransactionsScene()
                }, onMarketReportsTap: {
                    viewModel.openMarketReportsScene()
                }, onMarketSummaryTap: {
                    viewModel.openMarketSummaryScene()
                }, onTradingIndexTap: {
                    viewModel.openTradingIndexScene()
                }, onSectorsIndexTap: {
                    viewModel.openSectorsIndexScene()
                }, onMarketDealsTap: {
                    viewModel.openMarketDealsScene()
                }, onMarketNewsTap: {
                    viewModel.openMarketNewsScene()
                }, onListOfCompaniesTap: {
                    viewModel.openListOfCompaniesScene()
                }, onNotificationsTap: {
                    viewModel.openNotificationsScene()
                }, onChangePasswordTap: {
                    viewModel.openChangePasswordScene()
                }, onAccountReportsTap: {
                    viewModel.openAccountReportsScene()
                }, onBalanceDetailsTap: {
                    viewModel.openBalanceDetailsScene()
                },onPersonalInformationTap: {
                    viewModel.openPersonalInformationScene()
                }, onUploadDocumentTap: {
                    viewModel.openUploadDocumentTap()
                })
            })
        })
    }
}
