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
                .foregroundStyle(Color.colorTextPrimary)
                .frame(maxWidth: 150, alignment: .leading)

            Spacer()

            HStack(spacing: 0) {
                Text("value".localized)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

                Spacer()

                Text("change".localized)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

                Spacer()

                Text("change_percent".localized)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
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
                        Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: item.indexValue ?? 0))")
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        
                        Spacer()

                        Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: item.change ?? 0))")
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(item.change ?? 0 > 0 ? Color.colorGreen : Color.colorRed)
                        
                        Spacer()

                        Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: item.changePerc ?? 0))%")
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
    MarketOverviewContentView(marketsData: .constant([MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .yyMMddWithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04%", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254")]), indicesData: .constant([MarketOverviewUIModel(indexName: "General Index", indexValue: 9306.77, change: 3.36, changePerc: 0.036), MarketOverviewUIModel(indexName: "FTSE ADX Real Estate Index", indexValue: 10417.31, change: 104.60, changePerc: 1.014), MarketOverviewUIModel(indexName: "FTSE ADX Energy Index", indexValue: 2045.61, change: 4.43, changePerc: 0.217), MarketOverviewUIModel(indexName: "FTSE ADX Consumer Staples Index", indexValue: 14519.92, change: -351.41, changePerc: -2.363), MarketOverviewUIModel(indexName: "General Index", indexValue: 9306.77, change: 3.36, changePerc: 0.036), MarketOverviewUIModel(indexName: "FTSE ADX Real Estate Index", indexValue: 10417.31, change: 104.60, changePerc: 1.014), MarketOverviewUIModel(indexName: "FTSE ADX Energy Index", indexValue: 2045.61, change: 4.43, changePerc: 0.217), MarketOverviewUIModel(indexName: "FTSE ADX Consumer Staples Index", indexValue: 14519.92, change: -351.41, changePerc: -2.363), MarketOverviewUIModel(indexName: "General Index", indexValue: 9306.77, change: 3.36, changePerc: 0.036), MarketOverviewUIModel(indexName: "FTSE ADX Real Estate Index", indexValue: 10417.31, change: 104.60, changePerc: 1.014), MarketOverviewUIModel(indexName: "FTSE ADX Energy Index", indexValue: 2045.61, change: 4.43, changePerc: 0.217), MarketOverviewUIModel(indexName: "FTSE ADX Consumer Staples Index", indexValue: 14519.92, change: -351.41, changePerc: -2.363)]))
}
