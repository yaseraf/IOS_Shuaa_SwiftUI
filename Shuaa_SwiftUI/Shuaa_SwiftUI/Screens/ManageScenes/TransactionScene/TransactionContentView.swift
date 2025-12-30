//
//  TransactionContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI

struct TransactionsContentView: View {
    
    var onBackTap: () -> Void
    var onHistoryTap: () -> Void
    var onCashInTap: () -> Void
    var onCashOutTap: () -> Void
    var onSharesTransferTap: () -> Void
    var onMyAccountsTap: () -> Void
    
    var body: some View {
        VStack {
            headerView
            
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
            
            Text("transactions".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image("ic_history")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.colorPrimary)
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onHistoryTap()
                }
        }
        .padding(20)
    }
    
    private var contentView: some View {
        VStack {
//            HStack(spacing: 8) {
//                Circle()
//                    .fill(Color(hex: "#00B050").opacity(0.1))
//                    .frame(width: 40, height: 40)
//                    .overlay {
//                        Image("ic_cashIn")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 20, height: 20)
//                    }
//                
//                Text("cash_in".localized)
//                    .font(.apply(.medium, size: 16))
//                
//                Spacer()
//            }
//            .padding(16)
//            .frame(maxWidth: .infinity)
//            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
//            .onTapGesture {
//                onCashInTap()
//            }
            
            HStack(spacing: 8) {
                Circle()
                    .fill(Color(hex: "#E52E2E").opacity(0.1))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_cashOut")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                
                Text("cash_out".localized)
                    .font(.apply(.medium, size: 16))
                
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
            .onTapGesture {
                onCashOutTap()
            }
            
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.colorBGThird)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_transfer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                
                Text("shares_transfer".localized)
                    .font(.apply(.medium, size: 16))
                
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
            .onTapGesture {
                onSharesTransferTap()
            }
            
//            HStack(spacing: 8) {
//                Circle()
//                    .fill(Color.colorBGThird)
//                    .frame(width: 40, height: 40)
//                    .overlay {
//                        Image("ic_myAccounts")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 20, height: 20)
//                    }
//                
//                Text("my_accounts".localized)
//                    .font(.apply(.medium, size: 16))
//                
//                Spacer()
//            }
//            .padding(16)
//            .frame(maxWidth: .infinity)
//            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
//            .onTapGesture {
//                onMyAccountsTap()
//            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }


}
