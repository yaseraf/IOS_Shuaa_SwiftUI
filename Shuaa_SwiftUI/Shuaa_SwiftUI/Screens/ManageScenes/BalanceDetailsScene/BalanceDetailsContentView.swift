//
//  BalanceDetailsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
import SwiftUI

struct BalanceDetailsContentView: View {
    
    var userData:Binding<GetUserAccountsUIModel?>
    var portfolioData:Binding<GetPortfolioUIModel?>
    
    var onBackTap: () -> Void
    var onPortfolioTap:() -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            accountView
            
            contentView
            
            Spacer()
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(AppUtility.shared.isRTL ? "ic_rightArrow" : "ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onBackTap()
                }
            
            Spacer()
            
            Text("balance_details".localized)
                .font(.apply(.medium, size: 16))
            
            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var accountView: some View {
        HStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.colorBG)
                .overlay {
                    Image("ic_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            
            Text("\(userData.wrappedValue?.NIN ?? "") - \(AppUtility.shared.isRTL ? userData.wrappedValue?.ClientNameA ?? "" : userData.wrappedValue?.ClientNameE ?? "")")
                .font(.apply(.medium, size: 14))
                .padding(.horizontal, 8)
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 24, height: 24)
                Circle()
                    .stroke(lineWidth: 1).fill(Color.colorBorder)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
            
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 52)
        .frame(maxWidth: .infinity)
        .background(Color.colorBGHeader)
        .onTapGesture {
            onPortfolioTap()
        }
    }
    
    private var contentView: some View {
        
        let balance = Double(portfolioData.wrappedValue?.accountSummaries.balance ?? "") ?? 0
        let marketValue = Double(portfolioData.wrappedValue?.accountSummaries.marketValue ?? "") ?? 0
        let portfolioValue = balance + marketValue

        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("total_portfolio_value".localized)
                    .font(.apply(.regular, size: 12))
                
                Text(AppUtility.shared.formatThousandSeparator(number: portfolioValue))
                    .font(.apply(.bold, size: 12))
            }
            .padding(.vertical, 2)
            .frame(maxWidth: .infinity)
            .background(Color.colorBGThird)
            
            VStack(spacing: 0) {
                
                // Row 1
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("purchase_value".localized)
                            .font(.apply(.regular, size: 12))
                        Text("0.000")
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                    VStack(spacing: 0) {
                        Text("opening_balance".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: balance))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                }
                .padding(.vertical, 8)

                Divider()
                    .padding(.horizontal, 20)
                
                // Row 2
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("portfolio_value".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: portfolioValue))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                    VStack(spacing: 0) {
                        Text("commissions".localized)
                            .font(.apply(.regular, size: 12))
                        Text("0.000")
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                }
                .padding(.vertical, 8)

                Divider()
                    .padding(.horizontal, 20)
                
                // Row 3
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("expected_pnl".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.expectedProfitLoss ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                    VStack(spacing: 0) {
                        Text("realized_pnl".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.realisedProfitLoss ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                }
                .padding(.vertical, 8)

                Divider()
                    .padding(.horizontal, 20)
                
                // Row 4
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("net_pnl".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.netProfitLoss ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                    VStack(spacing: 0) {
                        Text("market_value".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.marketValue ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                }
                .padding(.vertical, 8)

                Divider()
                    .padding(.horizontal, 20)
                
                // Row 4
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("cost_value".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.holdingCost ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                    VStack(spacing: 0) {
                        Text("margin_facility".localized)
                            .font(.apply(.regular, size: 12))
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.facilityAmount ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 167.5)

                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
