//
//  ShareDetailsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ShareDetailsContentView: View {
    
//    var selectedStock:Binding<GetMarketWatchByProfileIDUIModel>
    var stockDetails:Binding<GetAllMarketWatchBySymbolUIModel?>
    var depthByPriceData:Binding<[MarketDepthUIModel]?>
    var depthByOrderData:Binding<[MarketDepthUIModel]?>
    var wholeShareTradesData:Binding<[GetSymbolTradesFullObjectUIModel]?>
    var shareTradesSummaryData:Binding<[SendSymbolTradesSummaryObjectUIModel]?>
    var newsData:Binding<[NewsUIModel]?>
    var marketNewsBySymbol:Binding<[GetAllMarketNewsBySymbolUIModel]?>
    var favoriteList:Binding<[GetMarketWatchByProfileIDUIModel]>

    var onNewsDetailsTap: ((GetAllMarketNewsBySymbolUIModel)->Void)
    
    enum ShareDetailsSections {
        case details
        case price
        case orders
        case trades
        case news
    }
    
    @State var selectedSection: ShareDetailsSections = .details
    
    var onBackTap: ()->Void
    var onChartTap: ()->Void
    var onBuyTap:(TypeOfTrade)->Void
    var onSellTap:(TypeOfTrade)->Void
    var onHeartTap: (String) -> Void

    var body: some View {
        VStack {
            
            headerView
            
            Spacer().frame(height: 20)
            
            sectionView
            
            if selectedSection == .details {
                ShareDetailsStockInfoContentView(stockDetails: stockDetails)
            } else if selectedSection == .price {
                DepthByPriceView(depthByPriceData: depthByPriceData)
            } else if selectedSection == .orders {
                DepthByOrderContentView(depthByOrderData: depthByOrderData)
            } else if selectedSection == .trades {
                ShareDetailsTradesContentView(wholeShareTradesData: wholeShareTradesData, shareTradesSummaryData: shareTradesSummaryData)
            } else if selectedSection == .news {
                NewsView(marketNewsBySymbol: marketNewsBySymbol, onNewsDetailsTap: onNewsDetailsTap)
            }
            
            Spacer()
            
            bottomButtonsView
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
            
            Text("share_details".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Button {
                onHeartTap(stockDetails.wrappedValue?.symbol ?? "")
            } label: {
                Circle()
                    .fill(Color.colorBGSecondary)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(favoriteList.wrappedValue.contains(where: {$0.symbol == stockDetails.wrappedValue?.symbol ?? ""}) == true ? "ic_heartFill" : "ic_heartEmpty")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(favoriteList.wrappedValue.contains(where: {$0.symbol == stockDetails.wrappedValue?.symbol ?? ""}) == false ? Color.white : Color.colorPrimary)
                            .frame(width: 20, height: 20)
                    }
            }

        }
        .padding(.horizontal, 24)
    }
    
    private var sectionView: some View {
        VStack {
            HStack {
                if UserDefaultController().isCompaniesLogoEnabled == true {
                    WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(stockDetails.wrappedValue?.symbol ?? "").jpg")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35, maxHeight: 35)
                                .padding(.horizontal, 4)
                                .foregroundStyle(.gray)
                        case .failure:
                            Image("ic_selectStock")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35, maxHeight: 35)
                                .padding(.horizontal, 4)
                                .foregroundStyle(.gray)
                        case .empty:
                            Image("ic_selectStock")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35, maxHeight: 35)
                                .foregroundStyle(.gray)
                        @unknown default:
                            Image("ic_selectStock")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35, maxHeight: 35)
                                .foregroundStyle(.gray)
                        }
                    }
                }

                Text("\(AppUtility.shared.isRTL ? "\(stockDetails.wrappedValue?.symbol ?? "") - \(stockDetails.wrappedValue?.symbolNameE ?? "")" : "\(stockDetails.wrappedValue?.symbolNameA ?? "") - \(stockDetails.wrappedValue?.symbol ?? "")")")
                    .font(.apply(.medium, size: 12))

                Spacer()
                
                HStack {
                    Text("chart_graph".localized)
                        .font(.apply(.medium, size: 12))
                        .foregroundStyle(Color.colorPrimary)
                    
                    Image("ic_graph")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1).foregroundStyle(Color.colorPrimary))
                .onTapGesture {
                    onChartTap()
                }
                
            }
            .padding(.horizontal, 15)
            
            Spacer().frame(height: 10)
            
            Divider()
            
            Spacer().frame(height: 10)
            
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 2) {
                        Image("ic_details")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selectedSection == .details ? Color.colorPrimary : Color.colorTextSecondary)
                            .frame(width: 16, height: 16)
                        
                        Text("details".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(selectedSection == .details ? Color.colorPrimary : Color.colorTextSecondary)
                    }
                    .padding(.vertical, 16)
                    .onTapGesture {
                        selectedSection = .details
                    }
                    
                    if selectedSection == .details {
                        Color.colorPrimary
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .padding(.horizontal, 6)
                    }
                    
                    Color.colorPrimary
                        .opacity(selectedSection == .details ? 1 : 0)
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Color.colorPrimary
                        .opacity(selectedSection == .price ? 1 : 0)
                    
                    HStack(spacing: 2) {
                        Image("ic_price")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selectedSection == .price ? Color.colorPrimary : Color.colorTextSecondary)
                            .frame(width: 16, height: 16)
                        
                        Text("price".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(selectedSection == .price ? Color.colorPrimary : Color.colorTextSecondary)
                    }
                    .padding(.vertical, 16)
                    .onTapGesture {
                        selectedSection = .price
                    }
                    
                    if selectedSection == .price {
                        Color.colorPrimary
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .padding(.horizontal, 6)
                    }
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)

                Spacer()

                VStack(spacing: 0) {
                    Color.colorPrimary
                        .opacity(selectedSection == .orders ? 1 : 0)
                    
                    HStack(spacing: 2) {
                        Image("ic_orders")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selectedSection == .orders ? Color.colorPrimary : Color.colorTextSecondary)
                            .frame(width: 16, height: 16)
                        
                        Text("orders".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(selectedSection == .orders ? Color.colorPrimary : Color.colorTextSecondary)
                    }
                    .padding(.vertical, 16)
                    .onTapGesture {
                        selectedSection = .orders
                    }
                    
                    if selectedSection == .orders {
                        Color.colorPrimary
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .padding(.horizontal, 6)
                    }
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)

                Spacer()

                VStack(spacing: 0) {
                    Color.colorPrimary
                        .opacity(selectedSection == .trades ? 1 : 0)
                    
                    HStack(spacing: 2) {
                        Image("ic_trades")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selectedSection == .trades ? Color.colorPrimary : Color.colorTextSecondary)
                            .frame(width: 16, height: 16)
                        
                        Text("trades".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(selectedSection == .trades ? Color.colorPrimary : Color.colorTextSecondary)
                    }
                    .padding(.vertical, 16)
                    .onTapGesture {
                        selectedSection = .trades
                    }
                    
                    if selectedSection == .trades {
                        Color.colorPrimary
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .padding(.horizontal, 6)
                    }
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)

                Spacer()

                VStack(spacing: 0) {
                    Color.colorPrimary
                        .opacity(selectedSection == .news ? 1 : 0)
                    
                    HStack(spacing: 2) {
                        Image("ic_news")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selectedSection == .news ? Color.colorPrimary : Color.colorTextSecondary)
                            .frame(width: 16, height: 16)
                        
                        Text("news".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(selectedSection == .news ? Color.colorPrimary : Color.colorTextSecondary)
                    }
                    .padding(.vertical, 16)
                    .onTapGesture {
                        selectedSection = .news
                    }
                    
                    if selectedSection == .news {
                        Color.colorPrimary
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .padding(.horizontal, 6)
                    }
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)

            }
            .padding(.horizontal, 12)
            
            Divider()

        }
    }
    
    private var bottomButtonsView: some View {
        HStack {
            Button {
                onBuyTap(.buy)
            } label: {
                Text("buy".localized)
                    .font(.apply(.medium, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.colorBuy))
            }

            Spacer()
            
            Button {
                onSellTap(.sell)
            } label: {
                Text("sell".localized)
                    .font(.apply(.medium, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.colorSell))
            }

            
        }
        .padding(.horizontal, 24)
    }
}
