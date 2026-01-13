//
//  MarketOverviewContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI

struct MarketOverviewContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>
    var indicesData:Binding<[MarketOverviewUIModel]?>

    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            titleView

            SharedMarketsView(marketsData: marketsData)
            
            indicesHeaderView
            
            ScrollView(showsIndicators: false) {
                indicesDataView
            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
        }
        .background(Color.colorBackground) // For Debug only
    }
    
    private var titleView: some View {
        HStack {
            Text("market_overview".localized)
                .font(.apply(.bold, size: 20))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        
    }
    
    private var indicesHeaderView: some View {
        HStack {
            Text("indices".localized)
                .font(.apply(.regular, size: 14))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 150, alignment: .leading)

            Spacer()

            HStack(spacing: 0) {
                Text("value".localized)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.white)

                Spacer()

                Text("change".localized)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.white)

                Spacer()

                Text("change_percent".localized)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(Color.colorBackgroundTertiary)
        .cornerRadius(12)
        .padding(.horizontal, 16)

    }
    
    private var indicesDataView: some View {
        VStack(spacing: 6) {
            ForEach(Array((indicesData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                HStack {
                    Text(item.indexName ?? "")
                        .font(.apply(.bold, size: 14))
                        .foregroundStyle(Color.colorTextPrimary)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: 150, alignment: .leading)
                    
                    Spacer()

                    HStack(spacing: 0) {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.indexValue ?? 0))")
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        
                        Spacer()

                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.change ?? 0))")
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(item.change ?? 0 > 0 ? Color.colorGreen : Color.colorRed)
                        
                        Spacer()

                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.changePerc ?? 0))%")
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(item.change ?? 0 > 0 ? Color.colorGreen : Color.colorRed)

                    }
                    .frame(maxWidth: .infinity)

                }
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.colorBackgroundSecondary)
                .cornerRadius(12)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    MarketOverviewContentView(
        marketsData: .constant([
            .initMockData()
        ]),
        indicesData: .constant(
            MarketOverviewUIModel.initMockDataArray()
        )
    )
}
