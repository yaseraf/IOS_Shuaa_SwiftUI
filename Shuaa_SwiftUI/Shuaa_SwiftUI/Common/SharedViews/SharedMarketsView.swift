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
                    Text("\(marketsData.wrappedValue?.first?.lastTradePrice ?? "")")
                        .font(.apply(.bold, size: 16))
                        .foregroundStyle(Color.colorTextPrimary)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(marketsData.wrappedValue?.first?.netChange ?? "")")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                        Text("\(marketsData.wrappedValue?.first?.netChangePerc ?? "")")
                            .font(.apply(.regular, size: 8))
                            .foregroundStyle(Color.colorGreen)

                    }
                }
                
                Button {
                    withAnimation {
                        showMarketDetails.toggle()
                    }
                } label: {
                    Image("ic_upArrow")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .rotationEffect(Angle(degrees: showMarketDetails ? 0 : 180))
                        .foregroundStyle(Color.colorTextPrimary)

                }

            }
            
            if showMarketDetails {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("turnover".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(marketsData.wrappedValue?.first?.turnover ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                        
                        HStack {
                            Text("volume".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(marketsData.wrappedValue?.first?.volume ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }

                        HStack {
                            Text("trades".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextSecondary)

                            Text("\(marketsData.wrappedValue?.first?.trades ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                    }
                    
                    Color.colorTextPrimary
                        .frame(width: 1)
                        .frame(maxHeight: 92)
                        .padding(.horizontal, 24)

                    VStack(alignment: .leading, spacing: -4) {
                        HStack(alignment: .center) {
                            Text("symbols_traded".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)

                            Text("\(marketsData.wrappedValue?.first?.symbolsTraded ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                        }
                        
                        HStack {
                            Text("\(marketsData.wrappedValue?.first?.tradesUp ?? "")")
                                .font(.apply(.medium, size: 14))
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
                            Text("\(marketsData.wrappedValue?.first?.tradesEqual ?? "")")
                                .font(.apply(.medium, size: 14))
                                .foregroundStyle(Color.colorTextPrimary)

                            Text("=")
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        
                        HStack {
                            Text("\(marketsData.wrappedValue?.first?.tradesDown ?? "")")
                                .font(.apply(.medium, size: 14))
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

    }
}
