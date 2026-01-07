//
//  HomeContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>
    var stocksData:Binding<[StocksUIModel]?>
    
    @State var symbolSearch = ""
    @State var isMenuOpen = false
    @State var showMarketDetails = true
    
    var onAccountInformationTap:()->Void
    var onMyDocumentsTap:()->Void
    var onMarketsInsightTap:()->Void
    var onMyAlertsTap:()->Void
    var onAccountStatements:()->Void
    var onCashDeposit:()->Void
    var onEquityTransferTap:()->Void
    var onTransfersTap:()->Void
    var onClientPortalTap:()->Void
    var onIPOTap:()->Void
    var onSettingsTap:()->Void
        
    var body: some View {
        ZStack {
            VStack {
                
                SharedHeaderView(symbolSearch: symbolSearch, isMenuOpen: isMenuOpen, withBackButton: false, onMenuTap: {
                    isMenuOpen.toggle()
                })
                
                marketsView
                
                ScrollView {
                    chartView
                    
                    stocksView
                }
                
                Spacer()
                
                HomeBottomBarView(selectedItem: .home)
                    .frame(maxWidth: .infinity)
            }
                        
            // Side Menu
            SharedSideMenuView(isMenuOpen: $isMenuOpen, onAccountInformationTap: onAccountInformationTap, onMyDocumentsTap: onMyDocumentsTap, onMarketsInsightTap: onMarketsInsightTap, onMyAlertsTap: onMyAlertsTap, onAccountStatements: onAccountStatements, onCashDeposit: onCashDeposit, onEquityTransferTap: onEquityTransferTap, onTransfersTap: onTransfersTap, onClientPortalTap: onClientPortalTap, onIPOTap: onIPOTap, onSettingsTap: onSettingsTap)
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    withAnimation(.easeInOut(duration: 0.3)) {
//                        isMenuOpen.toggle()
//                    }
//                }) {
//                    Image(systemName: "line.3.horizontal")
//                }
//            }
//        }
    }
        
    private var marketsView: some View {
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
        .padding(.horizontal, 16)
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
        .padding(.horizontal, 16)
    }
    
    private var stocksView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 32) {
                actionButton(action: {
                    
                }, image: "ic_overview", title: "overview".localized)
                
                actionButton(action: {
                    
                }, image: "ic_tops", title: "top_stocks".localized)

                actionButton(action: {
                    
                }, image: "ic_marketT&S", title: "market_time_sale".localized)

                actionButton(action: {
                    
                }, image: "ic_watchlist", title: "watchlist".localized)
            }
            .padding(.vertical, 12)
            
            Color.colorTextPrimary
                .frame(height: 0.7)
                .padding(.horizontal, 24)
            
            VStack(spacing: 12) {
                stocksHorizontalStack
                    .padding(.horizontal, 24)
            }
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

    }
    
    private func actionButton(action: @escaping ()->Void, image:String, title:String) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 2) {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.colorTextPrimary)

                Text(title)
                    .font(.apply(.medium, size: 10))
                    .foregroundStyle(Color.colorTextPrimary)
            }
        }
    }
    
    private func stockBanner(stockData: StocksUIModel, overlayColor: Color) -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(stockData.stockName ?? "")")
                        .font(.apply(.medium, size: 8))
                        .foregroundStyle(Color.colorTextPrimary)

                    Text("\(stockData.lastTradePrice ?? "")")
                        .font(.apply(.medium, size: 8))
                        .foregroundStyle(Color.colorTextSecondary)
                }
                
                if stockData.stockName?.isEmpty == false {
                    Color.colorTextPrimary
                        .frame(width: 1, height: 14)
                }

                VStack(alignment: .center, spacing: 0) {
                    Text("\(stockData.netChange ?? "")")
                        .font(.apply(.medium, size: 8))
                        .foregroundStyle(stockData.netChange?.contains("-") ?? false ? Color.colorRed : Color.colorGreen)

                    Text("\(stockData.netChangePerc ?? "")")
                        .font(.apply(.medium, size: 8))
                        .foregroundStyle(stockData.netChange?.contains("-") ?? false ? Color.colorRed : Color.colorGreen)
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
            .opacity(stockData.stockName?.isEmpty == false ? 1 : 0)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        overlayColor: item.netChange?.contains("-") ?? false ? Color.colorRed : Color.colorGreen
                    )
                }
            }
        }
    }
    
}

#Preview {
    HomeContentView(marketsData: .constant([MarketsUIModel(marketName: "ADX", marketStatus: "Pre-Open adjustment", marketDate: Date().toString(dateFormat: .yyMMddWithTime), lastTradePrice: "9,306.77", netChange: "3.36", netChangePerc: "0.04%", symbolsTraded: "2", tradesUp: "1", tradesEqual: "0", tradesDown: "1", turnover: "17,815,738", volume: "514,895", trades: "254")]), stocksData: .constant([StocksUIModel(stockName: "ETISALAT", lastTradePrice: "36.68", netChange: "0.100", netChangePerc: "10.00%"), StocksUIModel(stockName: "WATANIA", lastTradePrice: "0.650", netChange: "-0.004", netChangePerc: "-0.615%"), StocksUIModel(stockName: "ETISALAT", lastTradePrice: "36.68", netChange: "0.100", netChangePerc: "10.00%"), .initializer(),  .initializer(), StocksUIModel(stockName: "WATANIA", lastTradePrice: "0.650", netChange: "-0.004", netChangePerc: "-0.615%"), .initializer(), .initializer(), .initializer(), .initializer(), .initializer(), .initializer()]), symbolSearch: "", onAccountInformationTap: {
        
    }, onMyDocumentsTap: {
        
    }, onMarketsInsightTap: {
        
    }, onMyAlertsTap: {
        
    }, onAccountStatements: {
        
    }, onCashDeposit: {
        
    }, onEquityTransferTap: {
        
    }, onTransfersTap: {
        
    }, onClientPortalTap: {
        
    }, onIPOTap: {
        
    }, onSettingsTap: {
        
    })
}
