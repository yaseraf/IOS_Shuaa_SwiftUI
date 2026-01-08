//
//  TopStocksContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI

struct TopStocksContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>
    var topGainersData:Binding<[TopGainersUIModel]?>
    var topLosersData:Binding<[TopLosersUIModel]?>
    var topTurnoverData:Binding<[TopTurnoverUIModel]?>
    var topVolumeData:Binding<[TopVolumeUIModel]?>
    var topTradesData:Binding<[TopTradesUIModel]?>
    
    @State var isChartView = false

    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            SharedMarketsView(marketsData: marketsData)
            
            contentView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
        }
        .background(Color.colorBackground) // DEBUG
    }
    
    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            topGainersSectionView(
                title: "top_gainers".localized,
                data: topGainersData.wrappedValue ?? [],
                type: .topGainers
            )
            
            topLosersSectionView(
                title: "top_losers".localized,
                data: topLosersData.wrappedValue ?? [],
                type: .topLosers
            )
            
            topTurnoverSectionView(
                title: "top_turnover".localized,
                data: topTurnoverData.wrappedValue ?? [],
                type: .topTurnover
            )
            
            topVolumeSectionView(
                title: "top_volume".localized,
                data: topVolumeData.wrappedValue ?? [],
                type: .topVolume
            )
            
            topTradesSectionView(
                title: "top_trades".localized,
                data: topTradesData.wrappedValue ?? [],
                type: .topTrades
            )
        }
    }
    
    private func topGainersSectionView(title: String, data: [TopGainersUIModel], type: TopStocksType) -> some View {
        VStack(spacing: 4) {
            sectionTitleView(title: title, hasToggle: true)
            
            sectionHeaderView(type: type)
                        
            VStack(spacing: 4) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    rowView(
                        symbol: item.symbol ?? "",
                        price: item.price ?? 0,
                        volume: item.volume ?? 0,
                        change: item.change ?? 0,
                        changePerc: item.changePercent ?? 0,
                        valueWithChart: item.changePercent ?? 0,
                        isPerc: true
                    )
                }
            }
        }
    }
    
    private func topLosersSectionView(title: String, data: [TopLosersUIModel], type: TopStocksType) -> some View {
        VStack(spacing: 4) {
            sectionTitleView(title: title)

            sectionHeaderView(type: type)
                        
            VStack(spacing: 4) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    rowView(
                        symbol: item.symbol ?? "",
                        price: item.price ?? 0,
                        volume: item.volume ?? 0,
                        change: item.change ?? 0,
                        changePerc: item.changePercent ?? 0,
                        valueWithChart: item.changePercent ?? 0,
                        isPerc: true
                    )
                }
            }
        }
    }

    private func topTurnoverSectionView(title: String, data: [TopTurnoverUIModel], type: TopStocksType) -> some View {
        VStack(spacing: 4) {
            sectionTitleView(title: title)

            sectionHeaderView(type: type)
                        
            VStack(spacing: 4) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    rowView(
                        symbol: item.symbol ?? "",
                        price: item.price ?? 0,
                        volume: item.turnover ?? 0,
                        change: item.trades ?? 0,
                        changePerc: item.changePercent ?? 0,
                        valueWithChart: item.turnover ?? 0
                    )
                }
            }
        }
    }

    private func topVolumeSectionView(title: String, data: [TopVolumeUIModel], type: TopStocksType) -> some View {
        VStack(spacing: 4) {
            sectionTitleView(title: title)

            sectionHeaderView(type: type)
                        
            VStack(spacing: 4) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    rowView(
                        symbol: item.symbol ?? "",
                        price: item.price ?? 0,
                        volume: item.turnover ?? 0,
                        change: item.volume ?? 0,
                        changePerc: item.changePercent ?? 0,
                        valueWithChart: item.volume ?? 0
                    )
                }
            }
        }
    }

    private func topTradesSectionView(title: String, data: [TopTradesUIModel], type: TopStocksType) -> some View {
        VStack(spacing: 4) {
            sectionTitleView(title: title)

            sectionHeaderView(type: type)
                        
            VStack(spacing: 4) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    rowView(
                        symbol: item.symbol ?? "",
                        price: item.price ?? 0,
                        volume: item.turnover ?? 0,
                        change: item.trades ?? 0,
                        changePerc: item.changePercent ?? 0,
                        valueWithChart: item.trades ?? 0
                    )
                }
            }
        }
    }

    private func sectionTitleView(title: String, hasToggle: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(.apply(.regular, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            if hasToggle {
                Button {
                    withAnimation {  
                        isChartView.toggle()
                    }
                } label: {
                    Image(isChartView ? "ic_chart" : "ic_list")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.colorSymbol)
                        .frame(width: 18, height: 18)
                        .padding(4)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(lineWidth: 1).fill(Color.colorSymbol))
                }
            }
        }
        .padding(.horizontal, 28)
        .padding(.top, 4)

    }
    
    private func sectionHeaderView(type: TopStocksType) -> some View {
        HStack {
            Text("symbol".localized)
                .font(.apply(.regular, size: 12))
                .foregroundStyle(Color.colorTextPrimary)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: 85, alignment: .leading)

            HStack(spacing: 0) {
                Text("price".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(maxWidth: .infinity)

                Text(type == .topGainers || type == .topLosers ? "volume".localized : "turnover".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(maxWidth: .infinity)
                
                Text(type == .topGainers || type == .topLosers ? "top_stocks_change".localized : type == .topTurnover || type == .topTrades ? "trades".localized : "volume".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(maxWidth: .infinity)

                Text("top_stocks_change_perc".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color.colorBackgroundTertiary)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
    
    private func rowView(symbol: String, price: Double, volume: Double, change: Double, changePerc: Double, valueWithChart: Double, isPerc:Bool = false) -> some View {
        Button {
            
        } label: {
            HStack {
                Text(symbol)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: 85, alignment: .leading)
                
                if !isChartView {
                    HStack(spacing: 0) {
                            Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: price))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                                .frame(maxWidth: .infinity)

                            Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: volume))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                                .frame(maxWidth: .infinity)

                            Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: change))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                                .frame(maxWidth: .infinity)

                            Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: changePerc))%")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(changePerc > 0 ? Color.colorGreen : Color.colorRed)
                                .frame(maxWidth: .infinity)
                    }
                    .minimumScaleFactor(0.85)
                    .frame(maxWidth: .infinity)
                } else {
                    Spacer()
                    
                    Text("\(AppUtility.shared.formatThousandSeparator3Decimal(number: valueWithChart))\(isPerc ? "%" : "")")
                        .font(.apply(.bold, size: 12))
                        .foregroundStyle(Color.colorTextPrimary)
                        .padding(.horizontal, 6)
                }
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(isChartView ? changePerc > 0 ? Color.colorGreen : Color.colorRed : Color.colorBackgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    TopStocksContentView(marketsData: .constant([MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .yyMMddWithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04%", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254")]), topGainersData: .constant([TopGainersUIModel(symbol: "ETISALAT", price: 36.68, volume: 485395, change: 0.1, changePercent: 10)]), topLosersData: .constant([TopLosersUIModel(symbol: "WATANIA", price: 0.65, volume: 29500, change: -0.004, changePercent: -0.62)]), topTurnoverData: .constant([TopTurnoverUIModel(symbol: "ETISALAT", price: 36.68, turnover: 17796572.12, trades: 250, changePercent: 10), TopTurnoverUIModel(symbol: "WATANIA", price: 0.65, turnover: 19166, trades: 4, changePercent: -0.62)]), topVolumeData: .constant([TopVolumeUIModel(symbol: "ETISALAT", price: 36.68, turnover: 17796572.12, volume: 485395, changePercent: 10), TopVolumeUIModel(symbol: "WATANIA", price: 0.65, turnover: 19166, volume: 29500, changePercent: -0.62)]), topTradesData: .constant([TopTradesUIModel(symbol: "ETISALAT", price: 36.68, turnover: 17796572.12, trades: 250, changePercent: 10), TopTradesUIModel(symbol: "WATANIA", price: 0.65, turnover: 19166, trades: 4, changePercent: -0.62)]))
}
