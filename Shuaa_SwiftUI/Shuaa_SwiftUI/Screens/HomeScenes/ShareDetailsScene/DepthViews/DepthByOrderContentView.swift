//
//  DepthByOrderView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import Foundation
import SwiftUI

struct DepthByOrderContentView: View {
    
    var depthByOrderData:Binding<[MarketDepthUIModel]?>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("volume".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                        .frame(height: 40)
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
                        .frame(height: 40)
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
                        .frame(height: 40)
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
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                Rectangle().fill(Color.colorBGTable)
                                Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                            }
                        )
                }
                
                ForEach(Array((depthByOrderData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                    HStack(spacing: 0) {
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

                    }
                }

            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth:1).foregroundStyle(Color.colorBorderSecondary))
            .padding(4)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
    }
}
