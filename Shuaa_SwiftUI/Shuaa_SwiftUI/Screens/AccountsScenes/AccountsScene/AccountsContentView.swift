//
//  AccountsContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation
import SwiftUI

struct AccountsContentView: View {
        
    var userAccountsData:Binding<UserAccountsUIModel?>

    var body: some View {
        VStack {
            SharedHeaderView()
            
            titleView
            
            accountsView
            
            ScrollView(showsIndicators: false) {
                contentView
            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .accounts)
        }
        .background(Color.colorBackground)
    }
    
    private var titleView: some View {
        Text("account_information".localized)
            .font(.apply(.bold, size: 16))
            .foregroundStyle(Color.colorTextPrimary)
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
    
    private var contentView: some View {
        VStack {
            accountDataRowView(title: "balance".localized, value: userAccountsData.wrappedValue?.balance ?? 0)
            accountDataRowView(title: "buy_power".localized, value: userAccountsData.wrappedValue?.buyPower ?? 0)
            accountDataRowView(title: "expected_profit_loss".localized, value: userAccountsData.wrappedValue?.expectedProfitLoss ?? 0)
            accountDataRowView(title: "available_cash".localized, value: userAccountsData.wrappedValue?.availableCash ?? 0)
            accountDataRowView(title: "realised_profit_loss".localized, value: userAccountsData.wrappedValue?.realisedProfitLoss ?? 0)
            accountDataRowView(title: "facility_amount".localized, value: userAccountsData.wrappedValue?.facilityAmount ?? 0)
            accountDataRowView(title: "cost_value".localized, value: userAccountsData.wrappedValue?.costValue ?? 0)
            accountDataRowView(title: "market_value".localized, value: userAccountsData.wrappedValue?.marketValue ?? 0)
            accountDataRowView(title: "net_profit_loss".localized, value: userAccountsData.wrappedValue?.netProfitLoss ?? 0)
            accountDataRowView(title: "net_portfolio_value".localized, value: userAccountsData.wrappedValue?.netPortfolioValue ?? 0)
        }
    }
    
    private func accountDataRowView(title: String, value: Double) -> some View {
        HStack {
            Text(title)
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            Text("\(AppUtility.shared.formatThousandSeparator(number: value))")
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.colorBackgroundSecondary)
        .cornerRadius(8)
        .padding(.horizontal, 12)
    }
    
}

#Preview {
    AccountsContentView(
        userAccountsData: .constant(.initMockData())
    )
}
