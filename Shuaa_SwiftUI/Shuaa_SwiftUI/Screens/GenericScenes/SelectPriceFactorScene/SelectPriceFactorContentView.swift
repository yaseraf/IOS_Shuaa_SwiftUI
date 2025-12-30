//
//  SelectPriceFactorContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
import SwiftUI

struct SelectPriceFactorContentView: View {
    
    var alertCondition:Binding<AlertCondition?>
    var priceFactors:Binding<[PriceFactorUIModel]?>
    var listCriterias:Binding<[PriceFactorUIModel]?>
    
    @State var selectedPriceFactor:PriceFactorUIModel?
    @State var selectedListCriteria:PriceFactorUIModel?
        
    var onDismiss:() -> Void
    var onConfirm:(PriceFactorUIModel) -> Void
    
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
                
                Text("price_selection".localized)
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
    }

    private var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                
                if alertCondition.wrappedValue == .priceFactor {
                    ForEach(Array((priceFactors.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                        HStack {
                            Text(item.factorName ?? "")
                                .font(.apply(.regular, size: 16))
                            Spacer()
                            Image(item.factorId == selectedPriceFactor?.factorId ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .onTapGesture {
                            selectedPriceFactor = PriceFactorUIModel(factorId: item.factorId, factorName: item.factorName)
                        }
                        
                        if index < (priceFactors.wrappedValue?.count ?? 0) - 1 {
                            Divider()
                        }
                    }

                } else {
                    ForEach(Array((listCriterias.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                        HStack {
                            Text(item.factorName ?? "")
                                .font(.apply(.regular, size: 16))
                            Spacer()
                            Image(item.factorId == selectedListCriteria?.factorId ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .onTapGesture {
                            selectedListCriteria = PriceFactorUIModel(factorId: item.factorId, factorName: item.factorName)
                        }
                        if index < (listCriterias.wrappedValue?.count ?? 0) - 1 {
                            Divider()
                        }
                    }

                }
                
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    private var bottomButtonView: some View {
        Text("confirm".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                if alertCondition.wrappedValue == .priceFactor {
                    onConfirm(selectedPriceFactor ?? .initializer())
                } else {
                    onConfirm(selectedListCriteria ?? .initializer())
                }
            }
    }
}
