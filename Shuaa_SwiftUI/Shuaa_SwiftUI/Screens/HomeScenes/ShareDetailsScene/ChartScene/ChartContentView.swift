//
//  ChartContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI
import WebKit

final class WebViewStore: ObservableObject {
    let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        return WKWebView(frame: .zero, configuration: config)
    }()
}

struct WebView: UIViewRepresentable {
    @ObservedObject var store: WebViewStore
    var chartLoaded:Binding<Bool?>
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
//        let config = WKWebViewConfiguration()
//        config.websiteDataStore = .default() // persistent storage
//        return WKWebView(frame: .zero, configuration: config)
        return store.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            if chartLoaded.wrappedValue == true {return}
//            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
//            uiView.load(request)
            
            DispatchQueue.main.async {
                chartLoaded.wrappedValue = true
                uiView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
                uiView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
//                debugPrint("TradingView URL: \(url)")
            }
            
        }
    }
}

struct ChartContentView: View {
    
    var qscChartURL = "https://mobile.qatar-securities.com/tradingView/index.html?symbol=SymbolId&CompName=ExchangeId-IndicyIdComp&Exchange=ExchangeId&theme=ThemeId&ChartType=ChartTypeID"
    
    @StateObject var webViewStore = WebViewStore()
    var selectedStock:Binding<GetCompaniesLookupsUIModel?>
    var chartLoaded:Binding<Bool?>
    
    enum selectedChartPeriod: String {
        case dayChart = "1D"
        case weekChart = "1W"
        case monthChart = "1M"
        case yearChart = "1Y"
    }

    @State var selectedChartPeriod:selectedChartPeriod = .dayChart

    var onBackTap:()->Void
    var onBuyTap:(TypeOfTrade)->Void
    var onSellTap:(TypeOfTrade)->Void
    
    var body: some View {
        VStack {
            headerView
            
            Spacer().frame(height: 20)
            
            chartView
            
//            ScrollView(.vertical, showsIndicators: false) {
//                Image(AppUtility.shared.isDarkTheme ? "chartTemplateDark" : "chartTemplateLight")
//                    .resizable()
//                    .scaledToFit()
//            }
            
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
            
            Text("\(AppUtility.shared.isRTL ? selectedStock.wrappedValue?.shortNameA ?? "" : selectedStock.wrappedValue?.shortNameE ?? "") - \(selectedStock.wrappedValue?.symbol ?? "") \("details".localized)")
                .font(.apply(.medium, size: 16))
                .minimumScaleFactor(0.5)

            Spacer()
//            
//            Circle()
//                .fill(Color.colorBGSecondary)
//                .frame(width: 40, height: 40)
//                .opacity(0)
        }
        .padding(.horizontal, 24)
    }
    
    private var chartView: some View {
        let chartURL = qscChartURL
            .replacingOccurrences(of: "SymbolId", with: UserDefaultController().selectedSymbol ?? "")
            .replacingOccurrences(of: "ExchangeId", with: UserDefaultController().exchangeID ?? "")
            .replacingOccurrences(of: "ThemeId", with: UserDefaultController().isDarkMode == true ? "Night" : "Day")
            .replacingOccurrences(of: "ChartTypeID", with: "mountain")
        
        debugPrint(chartURL)
        
        return VStack {

            WebView(store: webViewStore, chartLoaded: chartLoaded, url: URL(string: chartURL)!)
            
//                FilledLineChart(chartData: dataChart)
//                    .filledTopLine(chartData: dataChart,
//                                   lineColour: ColourStyle(colour: .colorSuccess),
//                                   strokeStyle: StrokeStyle(lineWidth: 3))
//
//                    .averageLine(chartData: dataChart,
//                                 markerName:"",
//                                 labelPosition:.none,
//                                 lineColour: Color.colorBorderSecondary,
//                                 strokeStyle: StrokeStyle(lineWidth: 1, dash: [1,5]))
//                    .id(dataChart.id)



        }.frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .center)
//            .frame(height: 200)

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
                onBuyTap(.sell)
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
