//
//  DepthByPriceView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import SwiftUI

struct DepthByPriceView: View {
    
    var depthByPriceData:Binding<[MarketDepthUIModel]?>

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("offer".localized)
                        .font(.apply(.semiBold, size: 14))
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(Color.colorOffer)

                    
                    VStack(spacing: -6) {
                        Text("IMP".localized)
                            .font(.apply(.regular, size: 12))
                        Text("")
                            .font(.apply(.semiBold, size: 14))
                    }
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color.colorBGTable)
                    
                    Text("bid".localized)
                        .font(.apply(.semiBold, size: 14))
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(Color.colorBid)

                }

                HStack(spacing: 0) {
                    Text("#")
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                    
                    Text("volume".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                    
                    Text("offer".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                    
                    Text("bid".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                    
                    Text("volume".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                    
                    Text("#".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                }
                
                ForEach(Array((depthByPriceData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                    HStack(spacing: 0) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.askNumber ?? "") ?? 0))")
                            .font(.apply(.medium, size: 12))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Rectangle().foregroundStyle(Color.colorOffer)
                                    Rectangle().stroke(lineWidth: 1).foregroundStyle(Color.colorBorderSecondary)
                                }
                            )
                        
                        
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.askQty ?? "") ?? 0))")
                            .font(.apply(.medium, size: 12))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Rectangle().foregroundStyle(Color.colorOffer)
                                    Rectangle().stroke(lineWidth: 1).foregroundStyle(Color.colorBorderSecondary)
                                }
                            )

                        Text("\(AppUtility.shared.formatNumber(number: Double(item.ask ?? "") ?? 0))")
                            .font(.apply(.medium, size: 12))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Rectangle().foregroundStyle(Color.colorOffer)
                                    Rectangle().stroke(lineWidth: 1).foregroundStyle(Color.colorBorderSecondary)
                                }
                            )


                        Text("\(AppUtility.shared.formatNumber(number: Double(item.bid ?? "") ?? 0))")
                            .font(.apply(.medium, size: 12))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Rectangle().foregroundStyle(Color.colorBid)
                                    Rectangle().stroke(lineWidth: 1).foregroundStyle(Color.colorBorderSecondary)
                                }
                            )


                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.bidQty ?? "") ?? 0))")
                            .font(.apply(.medium, size: 12))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Rectangle().foregroundStyle(Color.colorBid)
                                    Rectangle().stroke(lineWidth: 1).foregroundStyle(Color.colorBorderSecondary)
                                }
                            )


                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.bidNumber ?? "") ?? 0))")
                            .font(.apply(.medium, size: 12))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Rectangle().foregroundStyle(Color.colorBid)
                                    Rectangle().stroke(lineWidth: 1).foregroundStyle(Color.colorBorderSecondary)
                                }
                            )

                    }
                }
            }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth:2).foregroundStyle(Color.colorBorderSecondary))
                .padding(4)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
    }
}
