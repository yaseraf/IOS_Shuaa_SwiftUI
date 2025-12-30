//
//  MarketSummaryContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation
import SwiftUI

struct MarketSummaryContentView: View {
    
    var marketSummaryData:Binding<[GetMarketIndiciesUIModel]?>
    var onBackTap:() -> Void
    
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
            
            Text("market_summary".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var contentView: some View {
        
        
        return VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("company".localized)
                    .font(.apply(.regular, size: 10))
                    .foregroundStyle(Color.colorTextSecondary)
                    .frame(minHeight: 40)
                    .frame(minWidth: 120)
                    .background(
                        ZStack {
                            Rectangle().fill(Color.colorBGTable)
                            Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                        }
                    )

                Text("value".localized)
                    .font(.apply(.regular, size: 10))
                    .foregroundStyle(Color.colorTextSecondary)
                    .frame(minHeight: 40)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            Rectangle().fill(Color.colorBGTable)
                            Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                        }
                    )

                Text("change".localized)
                    .font(.apply(.regular, size: 10))
                    .foregroundStyle(Color.colorTextSecondary)
                    .frame(minHeight: 40)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            Rectangle().fill(Color.colorBGTable)
                            Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                        }
                    )
                
                Text("change_perc".localized)
                    .font(.apply(.regular, size: 10))
                    .foregroundStyle(Color.colorTextSecondary)
                    .frame(minHeight: 40)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            Rectangle().fill(Color.colorBGTable)
                            Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                        }
                    )
            }
            .background(Color.colorBGThird)

            ForEach(Array((marketSummaryData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                
                let chg = Double(item.CI_CHG_INDEX ?? "") ?? 0
                let chgPerc = Double(item.CI_CHG_PERC_INDEX ?? "") ?? 0

                HStack(spacing: 0) {
                    Text("\(AppUtility.shared.isRTL ? item.CIA_DESC ?? "" : item.CIE_DESC ?? "")")
                        .font(.apply(.regular, size: 12))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 6)
                        .frame(minHeight: 40)
                        .frame(minWidth: 120, alignment: .leading)
                        .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.CI_CURRENT_INDEX ?? "") ?? 0))")
                        .font(.apply(.regular, size: 12))
                        .frame(minHeight: 40)
                        .frame(maxWidth: .infinity)
                        .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                    Text("\(chg > 0 ? "+" : chg <= 0 ? "" : "")\(AppUtility.shared.formatThousandSeparator(number: chg))")
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(chg > 0 ? Color.colorPositiveSecondary : chg < 0 ? Color.colorNegativeSecondary : chg == 0 ? Color.colorZero : Color.colorPrimary)
                        .frame(minHeight: 40)
                        .frame(maxWidth: .infinity)
                        .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                    Text("\(chgPerc > 0 ? "+" : chgPerc <= 0 ? "" : "")\(AppUtility.shared.formatThousandSeparator(number: chgPerc))%")
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(chgPerc > 0 ? Color.colorPositiveSecondary : chgPerc < 0 ? Color.colorNegativeSecondary : chgPerc == 0 ? Color.colorZero : Color.colorPrimary)
                        .frame(minHeight: 40)
                        .frame(maxWidth: .infinity)
                        .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                }
                .lineLimit(1)

            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth:1).fill(Color.colorBorderSecondary))
        .padding(.horizontal, 15)

    }

}
