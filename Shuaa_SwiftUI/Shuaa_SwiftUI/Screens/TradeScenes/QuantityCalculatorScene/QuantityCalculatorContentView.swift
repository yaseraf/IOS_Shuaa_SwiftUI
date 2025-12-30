//
//  SelectSharesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI

struct QuantityCalculatorContentView: View {
    
    var lastTradePrice: Binding<String?>
    var calculatedShares: Binding<String?>
    
    @State var amount:String = ""
    @State var sharesAmount:String = "0"
    
    enum Field {
        case amount
    }
    
    @FocusState private var focusedField: Field?
    
    var onCalculate:(String) -> Void
    var onDismiss:() -> Void
    
    var body: some View {
        VStack {
            headerView
                        
            contentView
            
            Spacer()
            
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("quantity_calculations".localized)
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
        VStack {
            HStack(spacing: 0) {

                VStack(alignment: .leading, spacing: 0) {
                    Text("available_price".localized)
                        .font(.apply(.regular, size: 14))
                    
                    Text(lastTradePrice.wrappedValue ?? "")
                        .font(.apply(.semiBold, size: 16))
                }
                
                Spacer()
                
                Divider()
                    .frame(height: 57)
                
                Spacer()

                VStack(alignment: .trailing, spacing: 0) {
                    Text("price".localized)
                        .font(.apply(.regular, size: 14))
                    
                    Text(UserDefaultController().price ?? "")
                        .font(.apply(.semiBold, size: 16))
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8).fill(AppUtility.shared.isDarkTheme ? Color(hex: "#1F1F1F") : Color(hex: "#F6F7FB"))
                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder)
                }
            )
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\("amount".localized) (\("qar".localized))".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("0".localized, text: $amount)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .amount)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                focusedField = nil
                            }
                        }
                    }
            }
            .padding(.horizontal, 25)
            
            Divider().background(Color.colorBorder)
            
            HStack {
                Text("shares".localized)
                    .font(.apply(.regular, size: 14))
                Spacer()
                Text(calculatedShares.wrappedValue ?? "")
                    .font(.apply(.regular, size: 14))
            }
            .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var bottomButtonView: some View {
        Text("calculate".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onCalculate(amount)
            }
    }
}
