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
                        isPerc: true,
                        type: .topGainers
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
                        isPerc: true,
                        type: .topLosers
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
                        valueWithChart: item.turnover ?? 0,
                        type: .topTurnover
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
                        valueWithChart: item.volume ?? 0,
                        type: .topVolume
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
                        valueWithChart: item.trades ?? 0,
                        type: .topTrades
                    )
                }
            }
        }
    }

    private func sectionTitleView(title: String, hasToggle: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(.apply(.regular, size: 14))
                .foregroundStyle(Color.white)
            
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
                .foregroundStyle(Color.white)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: 85, alignment: .leading)

            if !isChartView {
                HStack(spacing: 0) {
                    Text("price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)

                    Text(type == .topGainers || type == .topLosers ? "volume".localized : "turnover".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                    
                    Text(type == .topGainers || type == .topLosers ? "top_stocks_change".localized : type == .topTurnover || type == .topTrades ? "trades".localized : "volume".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)

                    Text("top_stocks_change_perc".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            } else {
                Spacer()
                
                Text(type == .topGainers || type == .topLosers ? "top_stocks_change_perc".localized : type == .topTurnover ? "value".localized : type == .topVolume ? "volume".localized : type == .topTrades ? "trades".localized : "")
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 6)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color.colorBackgroundTertiary)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
    
    private func rowView(symbol: String, price: Double, volume: Double, change: Double, changePerc: Double, valueWithChart: Double, isPerc:Bool = false, type: TopStocksType) -> some View {
        Button {
            
        } label: {
            HStack {
                if !isChartView {
                Text(symbol)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: 85, alignment: .leading)
                
                    HStack(spacing: 0) {
                            Text("\(AppUtility.shared.formatThousandSeparator(number: price))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                                .frame(maxWidth: .infinity)

                            Text("\(AppUtility.shared.formatThousandSeparator(number: volume))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                                .frame(maxWidth: .infinity)

                        Text("\(type == .topTurnover || type == .topTrades ? AppUtility.shared.formatThousandSeparatorNoDecimal(number: change) : AppUtility.shared.formatThousandSeparator(number: change))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                                .frame(maxWidth: .infinity)

                            Text("\(AppUtility.shared.formatThousandSeparator(number: changePerc))%")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(changePerc > 0 ? Color.colorGreen : Color.colorRed)
                                .frame(maxWidth: .infinity)
                    }
                    .minimumScaleFactor(0.85)
                    .frame(maxWidth: .infinity)
                } else {
                    Text(symbol)
                        .font(.apply(.bold, size: 14))
                        .foregroundStyle(Color.white)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: 85, alignment: .leading)

                    Spacer()
                    
                    Text("\(AppUtility.shared.formatThousandSeparator(number: valueWithChart))\(isPerc ? "%" : "")")
                        .font(.apply(.bold, size: 12))
                        .foregroundStyle(Color.white)
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
    TopStocksContentView(
        marketsData: .constant([
            .initMockData()
        ]),
        topGainersData: .constant([
            .initMockData()
        ]),
        topLosersData: .constant([
            .initMockData()
        ]),
        topTurnoverData: .constant(TopTurnoverUIModel.initMockDataArray()),
        topVolumeData: .constant(TopVolumeUIModel.initMockDataArray()),
        topTradesData: .constant(TopTradesUIModel.initMockDataArray())
    )
}
