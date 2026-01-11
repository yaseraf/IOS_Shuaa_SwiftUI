//
//  HomeContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>
    var stocksData:Binding<[StocksUIModel]?>
    
    var onOverviewTap:()->Void
    var onTopStocksTap:()->Void
                    
    var body: some View {
        VStack {
            
            SharedHeaderView()
            
            SharedMarketsView(marketsData: marketsData)
            
            ScrollView {
                chartView
                
                stocksView
            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
        }
    }
            
    private var chartView: some View {
        VStack {
            VStack {
                
            }
            .frame(height: 280)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)

        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
    
    private var stocksView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                actionButton(
                    action: {
                        onOverviewTap()
                    },
                    image: "ic_overview",
                    title: "overview".localized
                )
                
                Spacer()
                
                actionButton(
                    action: {
                        onTopStocksTap()
                    },
                    image: "ic_tops",
                    title: "top_stocks".localized
                )

                Spacer()
                
                actionButton(
                    action: {
                    
                    },
                    image: "ic_marketT&S",
                    title: "market_time_sale".localized
                )

                Spacer()
                
                actionButton(
                    action: {
                    
                    },
                    image: "ic_watchlist",
                    title: "watchlist".localized
                )
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            
            Color.colorTextPrimary
                .frame(height: 0.7)
                .padding(.horizontal, 12)
            
            VStack(spacing: 12) {
                stocksHorizontalStack
                    .padding(.horizontal, 12)
            }
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 12)

    }
    
    private func actionButton(action: @escaping ()->Void, image:String, title:String) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 2) {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.colorTextPrimary)

                Text(title)
                    .font(.apply(.medium, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
            }
        }
    }
    
    private func stockBanner(stockData: StocksUIModel, overlayColor: Color) -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(stockData.stockName ?? "")")
                        .font(.apply(.medium, size: 10))
                        .foregroundStyle(Color.colorTextPrimary)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: stockData.lastTradePrice ?? 0))")
                        .font(.apply(.medium, size: 10))
                        .foregroundStyle(Color.colorTextSecondary)
                }
                
                if stockData.stockName?.isEmpty == false {
                    Color.colorTextPrimary
                        .frame(width: 1, height: 18)
                }

                VStack(alignment: .center, spacing: 0) {
                    Text("\(AppUtility.shared.formatThousandSeparator(number: stockData.netChange ?? 0))")
                        .font(.apply(.medium, size: 10))
                        .foregroundStyle(stockData.netChange ?? 0 < 0 ? Color.colorRed : Color.colorGreen)

                    Text("\(AppUtility.shared.formatThousandSeparator(number: stockData.netChangePerc ?? 0))%")
                        .font(.apply(.medium, size: 10))
                        .foregroundStyle(stockData.netChange ?? 0 < 0 ? Color.colorRed : Color.colorGreen)
                }
            }
            .padding(.vertical, 4)
            .padding(.bottom, 6)
            
            VStack {
                
                Spacer()
                
                overlayColor
                    .frame(height: 18)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(stockData.stockName?.isEmpty == false ? 1 : 0)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(Color.colorBanner)
                RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 0.3).foregroundStyle(Color.colorTextSecondary)
            }
        )
    }

    private var stocksHorizontalStack: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

       return LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array((stocksData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                Button {
                    
                } label: {
                    stockBanner(
                        stockData: item,
                        overlayColor: item.netChange ?? 0 < 0 ? Color.colorRed : Color.colorGreen
                    )
                }
            }
        }
    }
}

#Preview {
    HomeContentView(
        marketsData: .constant([
            MarketsUIModel.initMockData()
        ]),
        stocksData: .constant([
            StocksUIModel(stockName: "ETISALAT", lastTradePrice: 36.68, netChange: 0.100, netChangePerc: 10.00),
            StocksUIModel(stockName: "WATANIA", lastTradePrice: 0.650, netChange: -0.004, netChangePerc: -0.615),
            StocksUIModel(stockName: "ETISALAT", lastTradePrice: 36.68, netChange: 0.100, netChangePerc: 10.00),
            .initializer(),
            .initializer(),
            StocksUIModel(stockName: "WATANIA", lastTradePrice: 0.650, netChange: -0.004, netChangePerc: -0.615),
            .initializer(),
            .initializer(),
            .initializer(),
            .initializer(),
            .initializer(),
            .initializer()
        ]),
        onOverviewTap: {
        
        },
        onTopStocksTap: {
        
        }
    )
}
