//
//  SharedMarketsView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI

struct SharedMarketsView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>
    
    @State private var showMarketDetails:Bool = true

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Text("\(marketsData.wrappedValue?.first?.marketName ?? "")")
                            .font(.apply(.bold, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)
                        
                        Color.colorTextPrimary
                            .frame(width: 1)
                            .frame(maxHeight: 12)

                        Text("\(marketsData.wrappedValue?.first?.marketStatus ?? "")")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                    }
                    
                    Text("\(marketsData.wrappedValue?.first?.marketDate ?? "")")
                        .font(.apply(.regular, size: 8))
                        .foregroundStyle(Color.colorTextPrimary)

                }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Text("\(AppUtility.shared.formatThousandSeparator(number: marketsData.wrappedValue?.first?.lastTradePrice ?? 0))")
                        .font(.apply(.bold, size: 22))
                        .foregroundStyle(Color.colorTextPrimary)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: marketsData.wrappedValue?.first?.netChange ?? 0))")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                        Text("\(AppUtility.shared.formatThousandSeparator(number: marketsData.wrappedValue?.first?.netChangePerc ?? 0))%")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                    }
                }
                
                Image("ic_upArrow")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .rotationEffect(Angle(degrees: showMarketDetails ? 0 : 180))
                    .foregroundStyle(Color.colorTextPrimary)

            }
            
            if showMarketDetails {
                HStack(alignment: .center, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("turnover".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.turnover ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                        
                        HStack {
                            Text("volume".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.volume ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }

                        HStack {
                            Text("trades".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.trades ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                    }
                    
                    Color.colorTextPrimary
                        .frame(width: 1)
                        .frame(maxHeight: 92)
                        .padding(.horizontal, 24)

                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .center) {
                            Text("symbols_traded".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)

                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.symbolsTraded ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                        
                        HStack {
                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.tradesUp ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Image("ic_imgUp")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 8)
                                .frame(maxWidth: 65)
                                .foregroundStyle(Color.colorGreen)
                        }

                        HStack {
                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.tradesEqual ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Text("=")
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        
                        HStack {
                            Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: marketsData.wrappedValue?.first?.tradesDown ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Image("ic_imgDown")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color.colorTextPrimary)

                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 8)
                                .frame(maxWidth: 65)
                                .foregroundStyle(Color.colorRed)
                        }
                    }

                }

            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .onTapGesture {
            withAnimation {
                showMarketDetails.toggle()
            }
        }

    }
}

#Preview {
    SharedMarketsView(
        marketsData: .constant([
            .initMockData()
        ])
    )
}
