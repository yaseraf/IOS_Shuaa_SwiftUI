//
//  SharedSideMenuView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 04/01/2026.
//

import Foundation
import SwiftUI

struct SharedSideMenuView: View {
    
    @Binding var isMenuOpen:Bool
    
    var onAccountInformationTap:()->Void
    var onMyDocumentsTap:()->Void
    var onMarketsInsightTap:()->Void
    var onMyAlertsTap:()->Void
    var onAccountStatements:()->Void
    var onCashDeposit:()->Void
    var onEquityTransferTap:()->Void
    var onTransfersTap:()->Void
    var onClientPortalTap:()->Void
    var onIPOTap:()->Void
    var onSettingsTap:()->Void

    var body: some View {
        ZStack {
            // Overlay dimming effect
            if isMenuOpen {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isMenuOpen = false
                        }
                    }
            }

            HStack {
                Spacer()
                
                SideMenuView(
                    isMenuOpen: $isMenuOpen,
                    onAccountInformationTap: onAccountInformationTap,
                    onMyDocumentsTap: onMyDocumentsTap,
                    onMarketsInsightTap: onMarketsInsightTap,
                    onMyAlertsTap: onMyAlertsTap,
                    onAccountStatements: onAccountStatements,
                    onCashDeposit: onCashDeposit,
                    onEquityTransferTap: onEquityTransferTap,
                    onTransfersTap: onTransfersTap,
                    onClientPortalTap: onClientPortalTap,
                    onIPOTap: onIPOTap,
                    onSettingsTap: onSettingsTap
                )
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .background(Color.white)
                    .offset(x: isMenuOpen ? 0 : UIScreen.main.bounds.width * 0.5)
            }
            .ignoresSafeArea()
        }
    }
}

struct SideMenuView: View {
    @Binding var isMenuOpen: Bool
    
    var onAccountInformationTap:()->Void
    var onMyDocumentsTap:()->Void
    var onMarketsInsightTap:()->Void
    var onMyAlertsTap:()->Void
    var onAccountStatements:()->Void
    var onCashDeposit:()->Void
    var onEquityTransferTap:()->Void
    var onTransfersTap:()->Void
    var onClientPortalTap:()->Void
    var onIPOTap:()->Void
    var onSettingsTap:()->Void

    var body: some View {
        VStack(spacing: 0) {
            // Header with logo
            VStack {
                Image("ic_logo")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.colorPrimary)
                    .padding(.top, 60)
                    .padding(.bottom, 30)
            }
            
            Color.colorPrimary
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            
            // Menu Items
            ScrollView {
                VStack(spacing: 0) {
                    MenuItemView(icon: "ic_accountInformation", title: "account_information".localized, action: onAccountInformationTap)
                    MenuItemView(icon: "ic_myDocuments", title: "my_documents".localized, action: onMyDocumentsTap)
                    MenuItemView(icon: "ic_marketsInsight", title: "markets_insight".localized, action: onMarketsInsightTap)
                    MenuItemView(icon: "ic_notification", title: "my_alerts".localized, action: onMyAlertsTap)
                    MenuItemView(icon: "ic_accountStatements", title: "account_statements".localized, action: onAccountStatements)
                    MenuItemView(icon: "ic_cashDeposit", title: "cash_deposit".localized, action: onCashDeposit)
                    MenuItemView(icon: "ic_equityTransfer", title: "equity_transfer".localized, action: onEquityTransferTap)
                    MenuItemView(icon: "ic_transfers", title: "transfers".localized, action: onTransfersTap)
                    MenuItemView(icon: "ic_clientPortal", title: "client_portal".localized, action: onClientPortalTap)
                    MenuItemView(icon: "ic_ipo", title: "ipo".localized, action: onIPOTap)
                    MenuItemView(icon: "ic_settings", title: "settings".localized, action: onSettingsTap)
                }
            }

            Spacer()
            
            // Logout Button
            Button(action: {
                // Logout action
            }) {
                Text("logout".localized)
                    .font(.apply(.semiBold, size: 16))
                    .foregroundColor(Color.colorBase)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.colorPrimary)
                    .cornerRadius(6)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 30)
            }
        }
        .background(Color.colorBackgroundSecondary)
    }
}

struct MenuItemView: View {
    let icon: String
    let title: String
    let action:()->Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 15) {
                Image("\(icon)")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.colorPrimary)
                
                Text(title)
                    .font(.apply(.bold, size: 16))
                    .foregroundColor(Color.colorPrimary)
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 6)
            .background(Color.colorBackgroundSecondary)
        }
        
        Color.colorPrimary
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .opacity(0.5)
    }
}

#Preview {
    SideMenuView(isMenuOpen: .constant(true), onAccountInformationTap: {
        
    }, onMyDocumentsTap: {
        
    }, onMarketsInsightTap: {
        
    }, onMyAlertsTap: {
        
    }, onAccountStatements: {
        
    }, onCashDeposit: {
        
    }, onEquityTransferTap: {
        
    }, onTransfersTap: {
        
    }, onClientPortalTap: {
        
    }, onIPOTap: {
        
    }, onSettingsTap: {
            
    })
}
