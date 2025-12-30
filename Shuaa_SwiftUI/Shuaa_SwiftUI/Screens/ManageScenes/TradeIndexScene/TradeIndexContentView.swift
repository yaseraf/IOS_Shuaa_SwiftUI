//
//  TradeIndexContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI

struct TradeIndexContentView: View {
    
    var qscChartURL = "https://mobile.qatar-securities.com/tradingView/index.html?symbol=ExchangeId-IndicyId&CompName=ExchangeId-IndicyIdComp&exchange=ExchangeId&theme=ThemeId&ChartType=ChartTypeID"
    
    @StateObject var webViewStore = WebViewStore()
    var chartLoaded:Binding<Bool?>
    
    enum SectionType {
        case shares
        case market
        case sectors
        case trades
        case news
    }
    
    var exchangeSummaryData:Binding<GetExchangeSummaryUIModel?>
    var lastUpdateTime:Binding<String?>
    
    @State var selectedSection: SectionType = .market
    @StateObject private var userDefaultController = UserDefaultController.instance

    var onBackTap:()->Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            statusHeaderView
            
            sectionsView
            
            ScrollView(.vertical, showsIndicators: false) {
                contentView
            }
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
            
            Text("trade_index".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var statusHeaderView: some View {
        HStack(spacing: 0) {
            Text("\("state".localized): ")
                .font(.apply(.regular, size: 12))
            Text("\(userDefaultController.marketStatusTitle ?? "")")
                .font(.apply(.medium, size: 12))
            
            Spacer()
            Text("\("latest_update".localized): ")
                .font(.apply(.regular, size: 12))
            Text(lastUpdateTime.wrappedValue ?? "")
                .font(.apply(.semiBold, size: 12))
            
        }
        .foregroundStyle(.white)
        .padding(.vertical, 12)
        .padding(.horizontal, 29)
        .background(Color.colorPrimary)
        .cornerRadius(24, corners: [.topLeft, .topRight])
    }
    
    private var sectionsView: some View {
        HStack(spacing: 0) {
//            VStack(spacing: 16) {
//                Text("shares".localized)
//                    .font(.apply(selectedSection == .shares ? .semiBold : .regular, size: 14))
//                    .foregroundStyle(selectedSection == .shares ? Color.colorPrimary : Color.colorTextSecondary)
//                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedSection == .shares ? 1 : 0)
//            }
//            .onTapGesture {
//                selectedSection = .shares
//            }
            Spacer()
            VStack(spacing: 16) {
                Text("market".localized)
                    .font(.apply(selectedSection == .market ? .semiBold : .regular, size: 14))
                    .foregroundStyle(selectedSection == .market ? Color.colorPrimary : Color.colorTextSecondary)
                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedSection == .market ? 1 : 0)
            }
            .onTapGesture {
                selectedSection = .market
            }
            Spacer()
//            VStack(spacing: 16) {
//                Text("sectors".localized)
//                    .font(.apply(selectedSection == .sectors ? .semiBold : .regular, size: 14))
//                    .foregroundStyle(selectedSection == .sectors ? Color.colorPrimary : Color.colorTextSecondary)
//                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedSection == .sectors ? 1 : 0)
//            }
//            .onTapGesture {
//                selectedSection = .sectors
//            }
//            Spacer()
//            VStack(spacing: 16) {
//                Text("trades".localized)
//                    .font(.apply(selectedSection == .trades ? .semiBold : .regular, size: 14))
//                    .foregroundStyle(selectedSection == .trades ? Color.colorPrimary : Color.colorTextSecondary)
//                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedSection == .trades ? 1 : 0)
//            }
//            .onTapGesture {
//                selectedSection = .trades
//            }
//            Spacer()
//            VStack(spacing: 16) {
//                Text("news".localized)
//                    .font(.apply(selectedSection == .news ? .semiBold : .regular, size: 14))
//                    .foregroundStyle(selectedSection == .news ? Color.colorPrimary : Color.colorTextSecondary)
//                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedSection == .news ? 1 : 0)
//            }
//            .onTapGesture {
//                selectedSection = .news
//            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }
    
    private var contentView: some View {
        let currentValue = Double(exchangeSummaryData.wrappedValue?.currentValue ?? "") ?? 0
        let chg = Double(exchangeSummaryData.wrappedValue?.netChange ?? "") ?? 0
        let chgPerc = Double(exchangeSummaryData.wrappedValue?.netChangePerc ?? "") ?? 0
        
        let chartURL = qscChartURL
            .replacingOccurrences(of: "IndicyId", with: "General%20Index")
            .replacingOccurrences(of: "ExchangeId", with: UserDefaultController().exchangeID ?? "")
            .replacingOccurrences(of: "ThemeId", with: UserDefaultController().isDarkMode == true ? "Night" : "Day")
            .replacingOccurrences(of: "ChartTypeID", with: "mountain")
        
        debugPrint(chartURL)

        return VStack(spacing: 0) {
            Text("market_information".localized)
                .font(.apply(.medium, size: 12))
                .frame(maxWidth: .infinity)
                .frame(minHeight: 36)
                .background(Color.colorBGSecondary)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("current_index".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(currentValue > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: currentValue))")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(currentValue > 0 ? Color.colorPositiveSecondary : currentValue < 0 ? Color.colorNegativeSecondary : currentValue == 0 ? Color.colorZero : Color.colorPrimary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("change_perc".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(chgPerc > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: chgPerc))%")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(chgPerc > 0 ? Color.colorPositiveSecondary : chgPerc < 0 ? Color.colorNegativeSecondary : chgPerc == 0 ? Color.colorZero : Color.colorPrimary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("ytd".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("0")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(Color.colorNegativeSecondary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                }
                .padding(.vertical, 8)

                Divider()
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("previous_index".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("0")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(Color.colorPositiveSecondary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("change".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(chg > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: chg))")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(chg > 0 ? Color.colorPositiveSecondary : chg < 0 ? Color.colorNegativeSecondary : chg == 0 ? Color.colorZero : Color.colorPrimary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("ytd".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("0")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(Color.colorNegativeSecondary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                }
                .padding(.vertical, 8)

            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity)
            
            Text("equity_etf_market_information".localized)
                .font(.apply(.medium, size: 12))
                .frame(maxWidth: .infinity)
                .frame(minHeight: 36)
                .background(Color.colorBGSecondary)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("trades".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.symbolsTraded ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("volume".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.volume ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("\("value".localized) (\("qar".localized))")
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("0") // Turnover
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                }
                .padding(.vertical, 8)
                
                Divider()
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Text("up".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.symbolsUP ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(Color.colorPositiveSecondary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("down".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.symbolsDown ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle(Color.colorNegativeSecondary)
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                    VStack(spacing: 0) {
                        Text("unchanged".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.symbolsUnChange ?? "") ?? 0))
                            .font(.apply(.semiBold, size: 12))
                    }
                    .frame(minWidth: 114.33)
                    Spacer()
                }
                .padding(.vertical, 8)
                
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity)
            
            VStack {

                WebView(store: webViewStore, chartLoaded: chartLoaded, url: URL(string: chartURL)!)

            }
            .frame(height: 400)
            .frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .center)

                
        }
    }

}
