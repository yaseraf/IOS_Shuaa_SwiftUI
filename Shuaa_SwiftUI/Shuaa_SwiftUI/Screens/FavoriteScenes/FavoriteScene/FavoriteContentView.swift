//
//  FavoriteContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct FavoriteContentView: View {
    
    enum HomeFilter {
        case all
        case gainers
        case losers
        case active
    }

    
    var marketWatchData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var exchangeSummaryData: Binding<[GetExchangeSummaryUIModel]?>
    var topGainerData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var topLoserData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var mostActiveData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var categoryFilter:Binding<[FilterCategoryModel]>
    var sectorTypeFilter:Binding<SectorTypes>
    var specificShareFilter:Binding<SpecificShareTypes>

    @State var selectedFilter: HomeFilter = .all

    // Row expansion state
    @State private var isStockExpanded = false
    @State private var selectedSymbol: String?
    @State private var currentTime = Date()

    // Symbol that just updated (shared)
    var updatedSymbol: Binding<String?>

    @StateObject private var userDefaultController = UserDefaultController.instance

    var onStockTap: ((GetMarketWatchByProfileIDUIModel) -> Void)
    var onFilterTap: () -> Void
    var onAlertsTap: () -> Void

    var body: some View {
        VStack {
            headerView

            Spacer().frame(height: 8)
            
            headerDataView
            
            filtersView
            
            contentView
            
            Spacer()
            
//            HomeBottomBarView(selectedItem: .favourite)
        }
        .onAppear {
            // Manually update every second
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }
    
    // MARK: - Header

    private var headerView: some View {
        HStack {
            Image("ic_bell")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .onTapGesture { onAlertsTap() }

            Spacer()

            HStack {
                Text("\(currentTime.toString(dateFormat: .HHmmss))")
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(.white)

                Text("\(userDefaultController.marketStatusTitle ?? "")")
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxHeight: 24)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(isMarketOpen() ? Color.colorPositiveSecondary : Color.colorNegativeSecondary)
            )

            Spacer()

            Image("ic_globe")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(userDefaultController.signalRConnected == true ? Color.colorPositiveSecondary : Color.colorNegativeSecondary)
                .frame(height: 24)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 24)
    }

    private var headerDataView: some View {
        HStack {
            VStack(alignment: .center, spacing: 0) {
                Text("trade_value".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)

                Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.first?.turnOver ?? "")?.rounded() ?? 0))
                    .font(.apply(.semiBold, size: 14))
            }

            Spacer()

            VStack(alignment: .center, spacing: 0) {
                Text("change_perc".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)

                HStack {
                    Image(exchangeSummaryData.wrappedValue?.first?.netChangePerc?.contains("-") == true ? "ic_chgDown" : "ic_chgUp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.first?.netChangePerc ?? "")?.rounded() ?? 0))%")
                        .font(.apply(.semiBold, size: 14))
                }
            }

            Spacer()

            VStack(alignment: .center, spacing: 0) {
                Text("index".localized)
                    .font(.apply(.regular, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)

                Text(AppUtility.shared.formatThousandSeparator(number: Double(exchangeSummaryData.wrappedValue?.first?.currentValue ?? "")?.rounded() ?? 0))
                    .font(.apply(.semiBold, size: 14))
            }

            Spacer()

            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 24, height: 24)
                .overlay(
                    Image("ic_upArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                )
                .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorderPrimary))
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color.colorBGSecondary)
    }

    // MARK: - Filters

    private var filtersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Image("ic_filter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .onTapGesture { onFilterTap() }

                HStack {
                    Text("all".localized)
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(selectedFilter == .all ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .all ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .all
                }

                HStack {
                    Text("\(topGainerData.wrappedValue?.count ?? 0)")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(selectedFilter == .gainers ? Color.white : Color.colorPrimary)

                    Text("gainers".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedFilter == .gainers ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .gainers ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .gainers
                }

                HStack {
                    Text("\(topLoserData.wrappedValue?.count ?? 0)")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(selectedFilter == .losers ? Color.white : Color.colorPrimary)

                    Text("losers".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedFilter == .losers ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .losers ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .losers
                }

                HStack {
                    Text("\(mostActiveData.wrappedValue?.count ?? 0)")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(selectedFilter == .active ? Color.white : Color.colorPrimary)

                    Text("active".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedFilter == .active ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .active ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .active
                }
            }
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 32)
    }

    // MARK: - Content

    private var contentView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Text("volume".localized).font(.apply(.medium, size: 12)).foregroundStyle(Color.colorTextSecondary)
                Text("offer".localized).font(.apply(.medium, size: 12)).foregroundStyle(Color.colorTextSecondary)
                Text("last_price".localized).font(.apply(.medium, size: 12)).foregroundStyle(Color.colorTextSecondary)
                Text("bid".localized).font(.apply(.medium, size: 12)).foregroundStyle(Color.colorTextSecondary)
                Text("volume".localized).font(.apply(.medium, size: 12)).foregroundStyle(Color.colorTextSecondary)
                Text("change_perc".localized).font(.apply(.medium, size: 12)).foregroundStyle(Color.colorTextSecondary)
            }
            .lineLimit(1)
            .frame(maxHeight: 27)
            .padding(.horizontal, 15)
            .padding(.vertical, 6)
            .minimumScaleFactor(0.5)

            Divider().frame(height: 2).background(Color.colorBorder)

            ScrollView(.vertical, showsIndicators: false) {
                if UserDefaultController().isClassificationBySectorEnabled == true {
                    sectorsView
                } else {
                    sectorlessView
                }
            }
        }
    }



    private var groupedMarketWatch: [String: [GetMarketWatchByProfileIDUIModel]] {
        let sourceData: [GetMarketWatchByProfileIDUIModel] =
            selectedFilter == .all ? (marketWatchData.wrappedValue ?? []) :
            selectedFilter == .gainers ? (topGainerData.wrappedValue ?? []) :
            selectedFilter == .losers ? (topLoserData.wrappedValue ?? []) :
            selectedFilter == .active ? (mostActiveData.wrappedValue ?? []) :
            []

        return Dictionary(grouping: sourceData) { item in
            let sector = item.sectorE?.trimmingCharacters(in: .whitespacesAndNewlines)
            return (sector?.isEmpty ?? true) ? "others".localized : sector!
        }
    }
    
    private var filteredMarketWatchData: [GetMarketWatchByProfileIDUIModel] {
        let sourceData: [GetMarketWatchByProfileIDUIModel] =
            selectedFilter == .all ? (marketWatchData.wrappedValue ?? []) :
            selectedFilter == .gainers ? (topGainerData.wrappedValue ?? []) :
            selectedFilter == .losers ? (topLoserData.wrappedValue ?? []) :
            selectedFilter == .active ? (mostActiveData.wrappedValue ?? []) :
            []
        
        return sourceData
    }

    
    private var sectorsView: some View {
        
        let sortedKeys = groupedMarketWatch.keys.sorted { lhs, rhs in
            if lhs == "others".localized { return false }   // "others" goes last
            if rhs == "others".localized { return true }
            return lhs < rhs
        }


        return ForEach(sortedKeys, id: \.self) { sectorCode in
            VStack(spacing: 0) {
                // Sector Header
                HStack {
                    Text(
                        AppUtility.shared.isRTL
                        ? (groupedMarketWatch[sectorCode]?.first?.sectorA?.isEmpty == false
                           ? groupedMarketWatch[sectorCode]?.first?.sectorA
                           : "others".localized) ?? "others".localized
                        : (sectorCode.isEmpty ? "others".localized : sectorCode)
                    )
                    .font(.apply(.medium, size: 12))

                    Spacer()
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(Color.colorBGSecondary)

                // Stocks under this sector
                ForEach(groupedMarketWatch[sectorCode] ?? [], id: \.symbol) { item in
                    LazyVStack(spacing: 0) {
                        StockRow(
                            item: item,
                            updatedSymbol: updatedSymbol,          // pass the Binding so the row can optionally reset it
                            isStockExpanded: $isStockExpanded,
                            selectedSymbol: $selectedSymbol
                        )
                        Divider().frame(height: 5).background(Color.colorBorder)
                    }
                    .onTapGesture { onStockTap(item) }
                }
            }
        }
    }
    
    private var sectorlessView: some View {
        return ForEach(filteredMarketWatchData, id: \.symbol) { item in
            LazyVStack(spacing: 0) {
                StockRow(
                    item: item,
                    updatedSymbol: updatedSymbol,          // pass the Binding so the row can optionally reset it
                    isStockExpanded: $isStockExpanded,
                    selectedSymbol: $selectedSymbol
                )
                Divider().frame(height: 5).background(Color.colorBorder)
            }
            .onTapGesture { onStockTap(item) }
        }

    }

    // MARK: - Helpers

    func isMarketOpen() -> Bool {
        (userDefaultController.marketStatusCode == "0002" || userDefaultController.marketStatusCode == "0003")
    }
}

// MARK: - Row

private struct StockRow: View {
    let item: GetMarketWatchByProfileIDUIModel

    // Binding to the shared "last updated symbol"
    @Binding var updatedSymbol: String?

    // Expansion state bindings from parent
    @Binding var isStockExpanded: Bool
    @Binding var selectedSymbol: String?

    // Local flash color state (unique per row)
    @State private var fieldColor: Color = .clear

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if UserDefaultController().isCompaniesLogoEnabled == true {
                    WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol ?? "").jpg")) { phase in
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

                HStack(spacing: 2) {
                    Text(item.symbol ?? "")
                        .font(.apply(.bold, size: 14))
                        .foregroundStyle(Color(hex: "#948F8D"))
                    Text(AppUtility.shared.isRTL ? " - \(item.symbolNameA ?? "")" : " - \(item.symbolNameE ?? "")")
                        .font(.apply(.semiBold, size: 14))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .padding(.horizontal, 4)

                Spacer()

                Button(action: {
                    withAnimation {
                        if selectedSymbol == nil || selectedSymbol == item.symbol {
                            isStockExpanded.toggle()
                        }
                        selectedSymbol = item.symbol
                    }
                }, label: {
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        )
                        .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorderPrimary))
                })
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 8)

            priceRow(item: item)

            if isStockExpanded && selectedSymbol == item.symbol {
                expandedContent(item: item)
            }
        }
        .background(fieldColor)
        // Observe only the value, not the binding itself
        .onChange(of: item) { newValue in
//            guard let newValue else { return }
//            if newValue == (item.symbol ?? "") {
//                flash()
//                // Optional: reset to allow repeated flashes for the same symbol
//                // Comment out if you handle this in your ViewModel.
//                updatedSymbol = nil
//            }
            
            flash()
        }
    }

    // MARK: - Flash

    private func flash() {
        withAnimation(.easeIn(duration: 0)) {
            fieldColor = Color(hex: "#FFFFE8")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: 0.5)) {
                fieldColor = .clear
            }
        }
    }

    // MARK: - Subviews (row internals)

    @ViewBuilder
    private func priceRow(item: GetMarketWatchByProfileIDUIModel) -> some View {
        HStack(spacing: 0) {

            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.offerVolume ?? "") ?? 0))")
                .font(.apply(.semiBold, size: 14))
                .frame(maxHeight: 32)
                .frame(maxWidth: .infinity)
                .background(Color.colorOffer.border(Color.colorBorder, width: 1))
                .clipped()

            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.offerPrice ?? "") ?? 0))")
                .font(.apply(.semiBold, size: 14))
                .frame(maxHeight: 32)
                .frame(maxWidth: .infinity)
                .background(Color.colorOffer.border(Color.colorBorder, width: 1))

            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.lastTradePrice ?? "") ?? 0))")
                .font(.apply(.semiBold, size: 14))
                .frame(maxHeight: 32)
                .frame(maxWidth: .infinity)
                .background(Color.colorNeutral.border(Color.colorBorder, width: 1))

            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.bidPrice ?? "") ?? 0))")
                .font(.apply(.semiBold, size: 14))
                .frame(maxHeight: 32)
                .frame(maxWidth: .infinity)
                .background(Color.colorBid.border(Color.colorBorder, width: 1))

            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.bidVolume ?? "") ?? 0))")
                .font(.apply(.semiBold, size: 14))
                .frame(maxHeight: 32)
                .frame(maxWidth: .infinity)
                .background(Color.colorBid.border(Color.colorBorder, width: 1))

            Text("\((item.netChangePerc ?? "").contains("-") ? "" : (Double(item.netChangePerc ?? "") ?? 0) > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.netChangePerc ?? "") ?? 0))%")
                .font(.apply(.semiBold, size: 14))
                .foregroundStyle(
                    (item.netChangePerc ?? "").contains("-")
                    ? (AppUtility.shared.isDarkTheme ? Color.white : Color.colorNegative)
                    : (Double(item.netChangePerc ?? "") ?? 0) > 0 ? Color.colorPositive : Color.colorTextPrimary
                )
                .frame(maxHeight: 32)
                .frame(maxWidth: .infinity)
                .background(
                    (item.netChangePerc ?? "").contains("-")
                    ? Color.colorBGNegative.border(Color.colorBorder, width: 1)
                    : (Double(item.netChangePerc ?? "") ?? 0) > 0
                        ? Color.colorBGPositive.border(Color.colorBorder, width: 1)
                        : Color.clear.border(Color.colorBorder, width: 1)
                )
        }
        .lineLimit(1)
        .frame(maxHeight: 32)
        .minimumScaleFactor(0.5)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.colorBorder, lineWidth: 3))
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private func expandedContent(item: GetMarketWatchByProfileIDUIModel) -> some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Text("trades_value".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.totalValue ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                VStack {
                    Text("trades_volume".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.totalVolume ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                VStack {
                    Text("accepted_trades".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.executed ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
            }

            Divider()

            HStack(spacing: 30) {
                VStack {
                    Text("open_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.openPrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                VStack {
                    Text("close_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.closePrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                VStack {
                    Text("low".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.lowPrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
                VStack {
                    Text("high".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.highPrice ?? "") ?? 0))")
                        .font(.apply(.bold, size: 12))
                }
            }

            Divider()

            HStack {
                // Trades today
                VStack {
                    Text("trades_today".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    GeometryReader { geometry in
                        let high = Double(item.highPrice ?? "") ?? 0
                        let low = Double(item.lowPrice ?? "") ?? 0
                        let total = high + low
                        let highRatio = total > 0 ? high / total : 0
                        let lowRatio = total > 0 ? low / total : 0

                        if total == 0 {
                            Color.colorPositiveSecondary
                                .frame(width: geometry.size.width, height: 4)
                                .clipShape(RoundedRectangle(cornerRadius: 80))
                        } else {
                            HStack(spacing: 0) {
                                Color.colorNegativeSecondary
                                    .frame(width: geometry.size.width * highRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: highRatio)

                                Color.colorPositiveSecondary
                                    .frame(width: geometry.size.width * lowRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: lowRatio)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 80))
                        }
                    }
                    .frame(height: 4)

                    HStack {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.highPrice ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                        Spacer()
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.lowPrice ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                    }
                }
                .padding(.horizontal, 8)

                // 52 Weeks
                VStack {
                    Text("trades_52Weeks".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)

                    GeometryReader { geometry in
                        let high = Double(item.wk52High ?? "") ?? 0
                        let low = Double(item.wk52Low ?? "") ?? 0
                        let total = high + low
                        let highRatio = total > 0 ? high / total : 0
                        let lowRatio = total > 0 ? low / total : 0

                        if total == 0 {
                            Color.colorPositiveSecondary
                                .frame(width: geometry.size.width, height: 4)
                                .clipShape(RoundedRectangle(cornerRadius: 80))
                        } else {
                            HStack(spacing: 0) {
                                Color.colorNegativeSecondary
                                    .frame(width: geometry.size.width * highRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: highRatio)

                                Color.colorPositiveSecondary
                                    .frame(width: geometry.size.width * lowRatio, height: 4)
                                    .animation(.easeInOut(duration: 0.4), value: lowRatio)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 80))
                        }
                    }
                    .frame(height: 4)

                    HStack {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.wk52High ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                        Spacer()
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.wk52Low ?? "") ?? 0))")
                            .font(.apply(.bold, size: 12))
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
    }
}
