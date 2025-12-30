//
//  MarketSummaryContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation
import SwiftUI

struct IndustrialSectorContentView: View {
    
    var qscChartURL = "https://mobile.qatar-securities.com/tradingView/index.html?symbol=ExchangeId-IndicyId&CompName=ExchangeId-IndicyIdComp&exchange=ExchangeId&theme=ThemeId&ChartType=ChartTypeID"

    @StateObject var webViewStore = WebViewStore()
    var chartLoaded:Binding<Bool?>

    
    var industrialSectorData:Binding<GetMarketIndiciesUIModel?>

    var onBackTap:() -> Void
    var onExploreCompaniesTap:() -> Void
    
    var body: some View {
        VStack {
            headerView
            
            contentView
            
            Spacer()
            
            bottomButtonView
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
            
            Text("industrial_sector".localized)
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
        let currentIndex = Double(industrialSectorData.wrappedValue?.CI_CURRENT_INDEX ?? "") ?? 0
        let chg = Double(industrialSectorData.wrappedValue?.CI_CHG_INDEX ?? "") ?? 0
        let chgPerc = Double(industrialSectorData.wrappedValue?.CI_CHG_PERC_INDEX ?? "") ?? 0

        let chartURL = qscChartURL
//            .replacingOccurrences(of: "IndicyId", with: "\(industrialSectorData.wrappedValue?.CIE_DESC ?? "")")
            .replacingOccurrences(of: "IndicyId", with: "General%20Index")
            .replacingOccurrences(of: "ExchangeId", with: UserDefaultController().exchangeID ?? "")
            .replacingOccurrences(of: "ThemeId", with: UserDefaultController().isDarkMode == true ? "Night" : "Day")
            .replacingOccurrences(of: "ChartTypeID", with: "mountain")
        
        debugPrint(chartURL)

        return VStack(spacing: 0) {
            Text("trade_index_for_industrial_sector".localized)
                .font(.apply(.medium, size: 12))
                .frame(maxWidth: .infinity)
                .frame(minHeight: 36)
                .background(Color.colorBGSecondary)
            
            HStack(spacing: 0) {
                Spacer()
                VStack {
                    Text("index_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text(AppUtility.shared.formatThousandSeparator(number: currentIndex))
                        .font(.apply(.semiBold, size: 12))
                        .foregroundStyle(currentIndex > 0 ? Color.colorPositiveSecondary : currentIndex < 0 ? Color.colorNegativeSecondary : currentIndex == 0 ? Color.colorZero : Color.colorPrimary)
                }
                Spacer()
                VStack {
                    Text("change".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text(AppUtility.shared.formatThousandSeparator(number: chg))
                        .font(.apply(.semiBold, size: 12))
                        .foregroundStyle(chg > 0 ? Color.colorPositiveSecondary : chg < 0 ? Color.colorNegativeSecondary : chg == 0 ? Color.colorZero : Color.colorPrimary)
                }
                Spacer()
                VStack {
                    Text("change_perc".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: chgPerc))%")
                        .font(.apply(.semiBold, size: 12))
                        .foregroundStyle(chgPerc > 0 ? Color.colorPositiveSecondary : chgPerc < 0 ? Color.colorNegativeSecondary : chgPerc == 0 ? Color.colorZero : Color.colorPrimary)
                }
                Spacer()
            }
            .padding(.vertical, 8)
            
            VStack {

                WebView(store: webViewStore, chartLoaded: chartLoaded, url: URL(string: chartURL)!)

            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity,  alignment: .center)

            
//            Image(AppUtility.shared.isDarkTheme ? "sectorChartTemplateDark" : "sectorChartTemplateLight")
//                .resizable()
//                .scaledToFit()
        }
        .frame(maxWidth: .infinity)

    }

    private var bottomButtonView: some View {
        Text("explore_companies".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onExploreCompaniesTap()
            }
    }
}
