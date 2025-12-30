//
//  CashInContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI


enum TypeOfCashOutTransactions {
    case chequeRequest
    case wireTransfer
}

struct CashOutContentView: View {
            
    var selectedTypeOfTransaction: Binding<TypeOfCashOutTransactions?>

    var userData:Binding<GetUserAccountsUIModel?>
    var banksList:Binding<[GetBankIBANUIModel]?>
    var selectedBank:Binding<GetBankIBANUIModel?>
    var transactionAmount:Binding<String>
    var availableBalance:Binding<Double?>
    var iban:Binding<String>

    @FocusState private var focusedField: Field?
    
    enum Field {
        case transactionAmount
        case cost
    }
    
    @State var amount:String = ""
    
    var onBackTap: () -> Void
    var onSendTap: () -> Void
    var onBankAccountTap: () -> Void
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
                            selectedTypeOfTransaction.wrappedValue == .chequeRequest ?
                            Color.colorStockUpliftHeaderGradient
                            : selectedTypeOfTransaction.wrappedValue == .wireTransfer ?
                            Color.colorStockWithdrawalHeaderGradient
                            : Color.clear ,
                            selectedTypeOfTransaction.wrappedValue == .chequeRequest ?
                            Color.colorStockUpliftHeaderGradient
                                .opacity(0)
                            : selectedTypeOfTransaction.wrappedValue == .wireTransfer ?
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
            
            Text("cash_out".localized)
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
        VStack {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("types_of_transactions".localized)
                    .font(.apply(.regular, size: 14))
                
                HStack {
                    HStack(spacing: 16) {
                        Image(selectedTypeOfTransaction.wrappedValue == .chequeRequest ? "ic_checkmarkPink" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("cheque_request".localized)
                            .font(.apply(.regular, size: 16))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: 72)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedTypeOfTransaction.wrappedValue == .chequeRequest ? ( AppUtility.shared.isDarkTheme ? Color.clear : Color(hex: "#E697C6").opacity(0.1)) : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedTypeOfTransaction.wrappedValue == .chequeRequest ? Color(hex: "#E697C6") : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        selectedTypeOfTransaction.wrappedValue = .chequeRequest
                    }
                    
                    HStack(spacing: 16) {
                        Image(selectedTypeOfTransaction.wrappedValue == .wireTransfer ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("wire_transfer".localized)
                            .font(.apply(.regular, size: 16))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: 72)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16).fill(selectedTypeOfTransaction.wrappedValue == .wireTransfer ? ( AppUtility.shared.isDarkTheme ? Color.clear : Color(hex: "#F7F8FB")) : Color.clear)
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(selectedTypeOfTransaction.wrappedValue == .wireTransfer ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        selectedTypeOfTransaction.wrappedValue = .wireTransfer
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack {
                Text("\("current_balance".localized) (\("QAR".localized))")
                    .font(.apply(.regular, size: 14))
                
                Spacer()
                
                Text("\(AppUtility.shared.formatThousandSeparator(number: availableBalance.wrappedValue ?? 0))")
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

            
            VStack(alignment: .leading, spacing: 0) {
                Text("please_select_your_bank_account".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    Text((selectedBank.wrappedValue != nil) ? " \(selectedBank.wrappedValue?.bankName ?? "") / \(String(selectedBank.wrappedValue?.bankAccNo?.suffix(5) ?? ""))" : "please_select_your_bank".localized)
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
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onBankAccountTap()
                }
            }
            
            if selectedTypeOfTransaction.wrappedValue == .wireTransfer {
                VStack(alignment: .leading, spacing: 0) {
                    Text("iban".localized)
                        .font(.apply(.semiBold, size: 14))
                    
                    TextField("iban".localized, text: iban)
                        .font(.apply(.regular, size: 14))
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                        .padding(.bottom, 8)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .cost)
                }
                .disabled(true)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("the_amount_is_in_qatari_riyals".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("please_enter_the_full_amount".localized, text: transactionAmount)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
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
        return transactionAmount.wrappedValue.isEmpty == false && selectedBank.wrappedValue != nil
    }

}
