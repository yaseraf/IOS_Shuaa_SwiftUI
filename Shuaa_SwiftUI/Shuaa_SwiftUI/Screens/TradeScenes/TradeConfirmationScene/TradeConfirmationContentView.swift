//
//  SelectSharesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI

struct TradeConfirmationContentView: View {
    
    var shares:Binding<String>
    var price:Binding<String>
    var value:Binding<String>
    var expiryDate:Binding<String>
    var selectedTypeOfTrade:Binding<TypeOfTrade>
    
    
    var onEditTap:() -> Void
    var onDismiss:() -> Void
    var onSendTap:() -> Void
    
    var body: some View {
        VStack {
            headerView
                        
            contentView
            
            Spacer()
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.colorBorder)
                .frame(maxWidth: 46, maxHeight: 4)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("confirmation".localized)
                    .font(.apply(.medium, size: 16))
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorder))
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
        }
        .padding(.top, 16)
    }
    
    
    private var contentView: some View {
        VStack(spacing: 16) {
            Text("are_you_sure_you_want_to_confirm_the_request".localized)
                .font(.apply(.regular, size: 16))

            HStack(spacing: 8) {
                InfoCard(title: "shares".localized, value: shares.wrappedValue)
                InfoCard(title: "price".localized, value: UserDefaultController().isMarketPrice == true ? "mkt".localized : price.wrappedValue)
            }

            HStack(spacing: 8) {
                InfoCard(title: "value".localized, value: value.wrappedValue)
                InfoCard(title: "expiry_date".localized, value: expiryDate.wrappedValue)
            }
            
            Divider()

            HStack(spacing: 8) {

                Button {
                    onEditTap()
                } label: {
                    Text("edit".localized)
                        .font(.apply(.medium, size: 16))
                        .foregroundStyle(Color.colorPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorPrimary))
                }

                
                Button {
                    onSendTap()
                } label: {
                    Text("\(selectedTypeOfTrade.wrappedValue.name)")
                        .font(.apply(.medium, size: 16))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12).fill(selectedTypeOfTrade.wrappedValue == .buy ? Color.colorBuy : Color.colorSell))
                }
            }
            .padding(.bottom, 8)
        }
            .padding(.horizontal, 24)
    }
}

struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.apply(.regular, size: 14))
            Text(value)
                .font(.apply(.semiBold, size: 16))
        }
        .frame(maxHeight: 68)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(AppUtility.shared.isDarkTheme ? Color(hex: "#1F1F1F") : Color(hex: "#F6F7FB"))
                RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
            }
        )
    }
}
