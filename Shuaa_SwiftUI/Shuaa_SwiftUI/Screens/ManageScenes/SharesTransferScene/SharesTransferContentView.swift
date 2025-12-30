//
//  CashInContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI

enum TypeOfTransaction {
    case stockUplift
    case stockWithdrawal
}

struct SharesTransferContentView: View {
    
    var userData:Binding<GetUserAccountsUIModel?>
    var selectedShare:Binding<GetCompaniesLookupsUIModel?>
    var transactionAmount:Binding<String>
    var availableShares:Binding<Double>
    var cost:Binding<String>
    var selectedTypeOfTransaction: Binding<TypeOfTransaction>
    
    enum Field {
        case transactionAmount
        case cost
    }
    
    @FocusState private var focusedField: Field?


    var onBackTap: () -> Void
    var onSendTap: () -> Void
    var onSelectSharesTap: () -> Void
    var onPortfolioTap: () -> Void
    
    var body: some View {
        VStack {
            VStack {
                headerView
                
                accountView
            }
            .background(
                Rectangle()
                   .fill(
                       LinearGradient(
                        colors: [
                            selectedTypeOfTransaction.wrappedValue == .stockUplift ?
                            Color.colorStockUpliftHeaderGradient
                            : selectedTypeOfTransaction.wrappedValue == .stockWithdrawal ?
                            Color.colorStockWithdrawalHeaderGradient
                            : Color.clear ,
                            selectedTypeOfTransaction.wrappedValue == .stockUplift ?
                            Color.colorStockUpliftHeaderGradient
                                .opacity(0)
                            : selectedTypeOfTransaction.wrappedValue == .stockWithdrawal ?
                            Color.colorStockWithdrawalHeaderGradient
                                .opacity(0)
                            : Color.clear
                        ],
                           startPoint: .top,
                           endPoint: .bottom
                       )
                   )
                   .frame(maxWidth: .infinity)
                   .ignoresSafeArea()
            )
            
            contentView
            
            Spacer()
            
            bottomButtonView
        }
        
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .fill(Color.colorBG)
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
            
            Text("shares_transfer".localized)
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
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBGHeader))
        .padding(.horizontal, 20)
        .onTapGesture {
            onPortfolioTap()
        }
    }
    
    private var contentView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("types_of_transactions".localized)
                    .font(.apply(.regular, size: 14))
                
                HStack {
                    HStack(spacing: 16) {
                        Image(selectedTypeOfTransaction.wrappedValue == .stockUplift ? "ic_checkmarkPink" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("stock_uplift".localized)
                            .font(.apply(.regular, size: 16))
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: 72)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedTypeOfTransaction.wrappedValue == .stockUplift ? ( AppUtility.shared.isDarkTheme ? Color.clear : Color(hex: "#E697C6").opacity(0.1)) : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedTypeOfTransaction.wrappedValue == .stockUplift ? Color(hex: "#E697C6") : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        selectedTypeOfTransaction.wrappedValue = .stockUplift
                    }
                    
                    HStack(spacing: 16) {
                        Image(selectedTypeOfTransaction.wrappedValue == .stockWithdrawal ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("stock_withdrawal".localized)
                            .font(.apply(.regular, size: 16))
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: 72)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedTypeOfTransaction.wrappedValue == .stockWithdrawal ? ( AppUtility.shared.isDarkTheme ? Color.clear : Color(hex: "#F7F8FB")) : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedTypeOfTransaction.wrappedValue == .stockWithdrawal ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        selectedTypeOfTransaction.wrappedValue = .stockWithdrawal
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("select_share".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    
                    Text(((selectedShare.wrappedValue != nil) ? "\((AppUtility.shared.isRTL ? selectedShare.wrappedValue?.companyA : selectedShare.wrappedValue?.companyE) ?? "") - \(selectedShare.wrappedValue?.symbol ?? "")" : "select_share".localized))
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onSelectSharesTap()
                }
            }
            
            HStack {
                Text("shares_available_in_portfolio".localized)
                    .font(.apply(.regular, size: 14))
                
                Spacer()
                
                Text("\(AppUtility.shared.formatThousandSeparator(number: availableShares.wrappedValue))")
                    .font(.apply(.semiBold, size: 16))

            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16).fill(AppUtility.shared.isDarkTheme ? Color(hex: "#1F1F1F") : Color(hex: "#F6F7FB"))
                    RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder)
                }
            )
            .padding(.top, 16)

            VStack(alignment: .leading, spacing: 4) {
                Text("quantity_of_shares".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("please_enter_the_full_amount".localized, text: transactionAmount)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .transactionAmount)
                   
                    
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("cost_in_riyal_qatari".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("please_enter_the_full_amount".localized, text: cost)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .cost)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                focusedField = nil
                            }
                        }
                    }
            }

        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }

    private var bottomButtonView: some View {
        Button {
            onSendTap()
        } label: {
            Text("send_request".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(.white)
                .frame(minHeight: 48)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(enableBtn() ? Color.colorPrimary : Color.colorPrimary.opacity(0.5)))
                .padding(.horizontal, 24)
        }
        .disabled(!enableBtn())

    }
    
    private func enableBtn() -> Bool {
        return transactionAmount.wrappedValue.isEmpty == false && cost.wrappedValue.isEmpty == false && selectedShare.wrappedValue != nil
    }

}
