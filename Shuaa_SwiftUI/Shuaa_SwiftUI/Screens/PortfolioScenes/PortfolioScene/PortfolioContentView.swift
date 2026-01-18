//
//  PortfolioContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation
import SwiftUI

struct PortfolioContentView: View {
        
    var userAccountsData:Binding<UserAccountsUIModel?>
    var portfolioData:Binding<PortfolioUIModel?>
    
    var labelsHeaderFontSize: CGFloat = 10
    var labelsHeaderFontColor = Color.white
    var labelsHeaderValuesFontSize: CGFloat = 12

    var body: some View {
        VStack {
            SharedHeaderView()
            
            titleView
            
            accountsView
            
            headersView
                .background {
                    contentView
                }
            
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .portfolio)
        }
        .background(Color.colorBackground)
    }
    
    private var titleView: some View {
        Text("portfolio".localized)
            .font(.apply(.bold, size: 16))
            .foregroundStyle(Color.white)
            .padding(.top, 16)
    }
    
    private var accountsView: some View {
        VStack {
            Text("\(userAccountsData.wrappedValue?.accountName ?? "")-\(userAccountsData.wrappedValue?.accountNumber ?? "")-\(userAccountsData.wrappedValue?.currency ?? "")")
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.colorBackgroundSecondary)
        .cornerRadius(8)
        .padding(.horizontal, 12)
    }

    private var headersView: some View {
        VStack(spacing: 4) {
            HStack {
                VStack(spacing: 2) {
                    Text("symbol".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("quantity".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("close_price".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("market_value".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("average_cost".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("cost_value".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("unrealize_pnl".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("realised_profit_loss".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("perc_pnl".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("perc_holding".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(Color.colorBackgroundTertiary)
            .cornerRadius(12)
            .padding(.horizontal, 12)
            
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(spacing: 2) {
                        Text("total".localized)
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.closePrice ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.marketValue ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.averageCost ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.costValue ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.unrealizePnL ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.realisedPnL ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.percPnL ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: portfolioData.wrappedValue?.percHolding ?? 0))")
                            .font(.apply(.bold, size: labelsHeaderValuesFontSize))
                            .foregroundStyle(labelsHeaderFontColor)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.colorTextField)
                .cornerRadius(12)
                .padding(.horizontal, 12)
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            Text("no_symbols_yet".localized)
                .font(.apply(.bold, size: 16))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

#Preview {
    PortfolioContentView(
        userAccountsData: .constant(.initMockData()),
        portfolioData: .constant(.initMockData())
    )
}
