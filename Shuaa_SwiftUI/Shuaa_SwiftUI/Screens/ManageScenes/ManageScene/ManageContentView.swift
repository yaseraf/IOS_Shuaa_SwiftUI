//
//  ManageContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI

struct ManageContentView:View {
    
    var onSettingTap:()->Void
    var onContactUsTap: () -> Void
    var onAppRatingTap: () -> Void
    var onLogoutTap: () -> Void
    var onSharesTransferTap: () -> Void
    var onMarketReportsTap:() -> Void
    var onMarketSummaryTap:() -> Void
    var onTradingIndexTap:() -> Void
    var onSectorsIndexTap:() -> Void
    var onMarketDealsTap:() -> Void
    var onMarketNewsTap:() -> Void
    var onListOfCompaniesTap:() -> Void
    var onNotificationsTap:() -> Void
    var onChangePasswordTap: () -> Void
    var onAccountReportsTap:() -> Void
    var onBalanceDetailsTap:() -> Void
    var onPersonalInformationTap:() -> Void
    var onUploadDocumentTap:() -> Void
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                
                manageAccountView
                
                transactionsView
                
                marketSummaryView
                
                accountSummaryView
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
            
            Spacer()
            
//            HomeBottomBarView(selectedItem: .menu)
//                .frame(maxWidth: .infinity)
        }
    }
    
    private var manageAccountView: some View {
        VStack(spacing: 0){
            HStack(spacing: 15) {
                Text("manage_account".localized)
                    .font(.apply(.semiBold, size: 16))
                
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 15)
           
            HStack(spacing: 15) {
                Image("ic_setting")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("setting".localized)
                    .font(.apply(.medium, size: 14))
                
                 Spacer()
            }
            .onTapGesture {
                onSettingTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_contactUs")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("contact_us".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onContactUsTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_appRating")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("app_rating".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onAppRatingTap()
            }
            
            Divider()
                .padding(.vertical, 12)
            
            HStack(spacing: 15) {
                Image("ic_logOut")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("log_out".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onLogoutTap()
            }
        }

    }
    
    private var transactionsView: some View {
        VStack(spacing: 0){
            HStack(spacing: 15) {
                Text("transactions".localized)
                    .font(.apply(.semiBold, size: 16))
                
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 15)

            HStack(spacing: 15) {
                Image("ic_sharesTransfer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("shares_transfer".localized)
                    .font(.apply(.medium, size: 14))
                
                 Spacer()
            }
            .onTapGesture {
                onSharesTransferTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_moneyTransfer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("money_transfer".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onSharesTransferTap()
            }
        }

    }
    
    private var marketSummaryView: some View {
        VStack(spacing: 0){
            HStack(spacing: 15) {
                Text("market_summary".localized)
                    .font(.apply(.semiBold, size: 16))
                
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 15)
            
            HStack(spacing: 15) {
                Image("ic_marketReports")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("market_summary".localized)
                    .font(.apply(.medium, size: 14))
                
                 Spacer()
            }
            .onTapGesture {
                onMarketSummaryTap()
            }

            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_marketReports")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("market_reports".localized)
                    .font(.apply(.medium, size: 14))
                
                 Spacer()
            }
            .onTapGesture {
                onMarketReportsTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_tradingIndex")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("trading_index".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onTradingIndexTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_sectorsIndex")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("sectors_index".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onSectorsIndexTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_marketReports")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("market_deals".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onMarketDealsTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_marketNews")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("market_news".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onMarketNewsTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_listOfCompanies")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("list_of_companies".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onListOfCompaniesTap()
            }
            
            Divider()
            .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_notifications")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("notifications".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onNotificationsTap()
            }
        }

    }
    
    private var accountSummaryView: some View {
        VStack(spacing: 0){
            HStack(spacing: 15) {
                Text("account_summary".localized)
                    .font(.apply(.semiBold, size: 16))
                
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 15)

            HStack(spacing: 15) {
                Image("ic_changePassword")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("change_password".localized)
                    .font(.apply(.medium, size: 14))
                
                 Spacer()
            }
            .onTapGesture {
                onChangePasswordTap()
            }
            
            Divider()
                .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_accountReports")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("account_reports".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onAccountReportsTap()
            }
            
            Divider()
                .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_balanceDetails")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("balance_details".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onBalanceDetailsTap()
            }
            
//            Divider()
//                .padding(.vertical, 12)
//
//            HStack(spacing: 15) {
//                Image("ic_personalInformation")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//                
//                Text("personal_information".localized)
//                    .font(.apply(.medium, size: 14))
//                
//                Spacer()
//            }
//            .onTapGesture {
//                onPersonalInformationTap()
//            }
            
            Divider()
                .padding(.vertical, 12)

            HStack(spacing: 15) {
                Image("ic_uploadDocument")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("upload_document".localized)
                    .font(.apply(.medium, size: 14))
                
                Spacer()
            }
            .onTapGesture {
                onUploadDocumentTap()
            }
        }

    }
}
