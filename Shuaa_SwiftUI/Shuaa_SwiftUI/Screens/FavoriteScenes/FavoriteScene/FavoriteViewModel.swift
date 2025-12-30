//
//  FavoriteViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
class FavoriteViewModel: ObservableObject {
    private var coordinator: FavoriteCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol

    @Published var portfolioInsuranceData: [HomePortfolioUIModel]?
    @Published var portfolioIdustrialsData: [HomePortfolioUIModel]?
    
    @Published var marketWatchData: [GetMarketWatchByProfileIDUIModel]?
    @Published var tempMarketWatchData: [GetMarketWatchByProfileIDUIModel]?
    
    @Published var exchangeSummaryData: [GetExchangeSummaryUIModel]?
    @Published var topGainerData: [GetMarketWatchByProfileIDUIModel]?
    @Published var topLoserData: [GetMarketWatchByProfileIDUIModel]?
    @Published var mostActiveData: [GetMarketWatchByProfileIDUIModel]?
    
    @Published var tempTopGainerData: [GetMarketWatchByProfileIDUIModel]?
    @Published var tempTopLoserData: [GetMarketWatchByProfileIDUIModel]?
    @Published var tempMostActiveData: [GetMarketWatchByProfileIDUIModel]?

    @Published var categoryFilter: [FilterCategoryModel] = []
    @Published var sectorTypeFilter: SectorTypes = .none
    @Published var specificShareFilter: SpecificShareTypes = .none

    @Published var updatedSymbol:String?

    @Published var getAllProfilesLookupsByUserCodeAPIResult:APIResultType<[GetAllProfilesLookupsByUserCodeUIModel]>?
    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var getExchangeSummaryAPIResult:APIResultType<[GetExchangeSummaryUIModel]>?


    init(coordinator: FavoriteCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        resetData()
    }
}

// MARK: Mock Data
extension FavoriteViewModel {
    func getPortfolioData() {
//        var data: [HomePortfolioUIModel] = []
//        
//        data.append(HomePortfolioUIModel(stockId: 1, image: "ic_QNB", name: "QNB", fullNameE: "Qatar National Bank", fullNameN: "بنك قطر الوطني", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 2, image: "ic_QNBK", name: "QNBK", fullNameE: "Doha Bank", fullNameN: "بنك الدوحة", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: -1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 3, image: "ic_ABQK", name: "ABQK", fullNameE: "Ahli Bank", fullNameN: "البنك الأهلي", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 4, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameN: "مجموعة الدوحة للتأمين", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        portfolioInsuranceData = data
//        
//        data.removeAll()
//        
//        data.append(HomePortfolioUIModel(stockId: 5, image: "ic_DUBK", name: "DUBK", fullNameE: "Dukhan Bank", fullNameN: "بنك دخان", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: -1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 6, image: "ic_QIB", name: "QIB", fullNameE: "AlMaref", fullNameN: "المصرف", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 7, image: "ic_QATI", name: "QATI", fullNameE: "Qatar Insurance Group", fullNameN: "مجموعة قطر للتأمين", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        portfolioIdustrialsData = data
    }

}

// MARK: Routing
extension FavoriteViewModel {
    func openShareDetails(selectedStock: GetMarketWatchByProfileIDUIModel) {
        UserDefaultController().selectedSymbol = selectedStock.symbol
        UserDefaultController().selectedSymbolType = selectedStock.marketType
        
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.openShareDetailsScene()
    }
    
    func openFilterScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.openFilterScene(delegate: self, categoryFilter: categoryFilter, specificSharesFilter: specificShareFilter ?? .none, sectorTypeFilter: sectorTypeFilter ?? .none)
    }
    
    func openAlertsScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openAlertsScene()
    }
}

// MARK: Functions
extension FavoriteViewModel {
    func resetData() {
        marketWatchData = []
        topGainerData = []
        topLoserData = []
        mostActiveData = []
    }

    func filterData() {
        var filteredMarketWatchStocks: [GetMarketWatchByProfileIDUIModel] {
            tempMarketWatchData?.filter { item in
                
                // 1. Specific share filter
                if specificShareFilter == .islamic {
                    guard item.islM?.lowercased() == "y" else { return false }
                }
                
                // 2. Sector type filter
                switch sectorTypeFilter {
                case .active:
                    guard Double(item.executed ?? "") ?? 0 > 0 else { return false }
                    
                case .up:
                    guard Double(item.netChangePerc ?? "") ?? 0 > 0 else { return false }
                    
                case .down:
                    guard Double(item.netChangePerc ?? "") ?? 0 < 0 else { return false }
                    
                case .constant:
                    guard Double(item.netChangePerc ?? "") ?? 0  == 0 else { return false }
                    
                case .favorites:
                    return true
                case .none:
                    debugPrint("no sector filter selected")
                }

                // 3. Category filter
                if !categoryFilter.isEmpty && !categoryFilter.contains(where: { $0.name.lowercased() == "all" }) {
                    let sectorName = AppUtility.shared.isRTL ? item.sectorA?.lowercased() : item.sectorE?.lowercased()
//                    guard categoryFilter.contains(where: {$0.name.lowercased() == sectorName}) else { return false }
                    guard categoryFilter.contains(where: { word in item.sectorE?.lowercased().contains(word.name) ?? false}) else { return false }
                }
                
                return true
            } ?? []
        }
        var filteredTopGainerStocks: [GetMarketWatchByProfileIDUIModel] {
            tempTopGainerData?.filter { item in
                
                // 1. Specific share filter
                if specificShareFilter == .islamic {
                    guard item.islM?.lowercased() == "y" else { return false }
                }
                
                // 2. Sector type filter
                switch sectorTypeFilter {
                case .active:
                    guard Double(item.executed ?? "") ?? 0 > 0 else { return false }
                    
                case .up:
                    guard Double(item.netChangePerc ?? "") ?? 0 > 0 else { return false }
                    
                case .down:
                    guard Double(item.netChangePerc ?? "") ?? 0 < 0 else { return false }
                    
                case .constant:
                    guard Double(item.netChangePerc ?? "") ?? 0  == 0 else { return false }
                    
                case .favorites:
                    return true
                case .none:
                    debugPrint("no sector filter selected")
                }

                // 3. Category filter
                if !categoryFilter.isEmpty && !categoryFilter.contains(where: { $0.name.lowercased() == "all" }) {
                    let sectorName = AppUtility.shared.isRTL ? item.sectorA?.lowercased() : item.sectorE?.lowercased()
//                    guard categoryFilter.contains(where: {$0.name.lowercased() == sectorName}) else { return false }
                    guard categoryFilter.contains(where: { word in item.sectorE?.lowercased().contains(word.name) ?? false}) else { return false }
                }
                
                return true
            } ?? []
        }
        var filteredTopLoserStocks: [GetMarketWatchByProfileIDUIModel] {
            tempTopLoserData?.filter { item in
                
                // 1. Specific share filter
                if specificShareFilter == .islamic {
                    guard item.islM?.lowercased() == "y" else { return false }
                }
                
                // 2. Sector type filter
                switch sectorTypeFilter {
                case .active:
                    guard Double(item.executed ?? "") ?? 0 > 0 else { return false }
                    
                case .up:
                    guard Double(item.netChangePerc ?? "") ?? 0 > 0 else { return false }
                    
                case .down:
                    guard Double(item.netChangePerc ?? "") ?? 0 < 0 else { return false }
                    
                case .constant:
                    guard Double(item.netChangePerc ?? "") ?? 0  == 0 else { return false }
                    
                case .favorites:
                    return true
                case .none:
                    debugPrint("no sector filter selected")
                }

                // 3. Category filter
                if !categoryFilter.isEmpty && !categoryFilter.contains(where: { $0.name.lowercased() == "all" }) {
                    let sectorName = AppUtility.shared.isRTL ? item.sectorA?.lowercased() : item.sectorE?.lowercased()
//                    guard categoryFilter.contains(where: {$0.name.lowercased() == sectorName}) else { return false }
                    guard categoryFilter.contains(where: { word in item.sectorE?.lowercased().contains(word.name) ?? false}) else { return false }
                }
                
                return true
            } ?? []
        }
        var filteredMostActiveStocks: [GetMarketWatchByProfileIDUIModel] {
            tempMostActiveData?.filter { item in
                
                // 1. Specific share filter
                if specificShareFilter == .islamic {
                    guard item.islM?.lowercased() == "y" else { return false }
                }
                
                // 2. Sector type filter
                switch sectorTypeFilter {
                case .active:
                    guard Double(item.executed ?? "") ?? 0 > 0 else { return false }
                    
                case .up:
                    guard Double(item.netChangePerc ?? "") ?? 0 > 0 else { return false }
                    
                case .down:
                    guard Double(item.netChangePerc ?? "") ?? 0 < 0 else { return false }
                    
                case .constant:
                    guard Double(item.netChangePerc ?? "") ?? 0  == 0 else { return false }
                    
                case .favorites:
                    return true
                case .none:
                    debugPrint("no sector filter selected")
                }

                // 3. Category filter
                if !categoryFilter.isEmpty && !categoryFilter.contains(where: { $0.name.lowercased() == "all" }) {
                    let sectorName = AppUtility.shared.isRTL ? item.sectorA?.lowercased() : item.sectorE?.lowercased()
//                    guard categoryFilter.contains(where: {$0.name.lowercased() == sectorName}) else { return false }
                    guard categoryFilter.contains(where: { word in item.sectorE?.lowercased().contains(word.name) ?? false}) else { return false }
                }
                
                return true
            } ?? []
        }
                
        marketWatchData = filteredMarketWatchStocks
        topGainerData = filteredTopGainerStocks
        topLoserData = filteredTopLoserStocks
        mostActiveData = filteredMostActiveStocks
                
    }

}

// MARK: API Calls
extension FavoriteViewModel {
    func callGetAllProfilesLookupsByUserCodeAPI() {
        
        let requestModel = GetAllProfilesLookupsByUserCodeRequestModel()
        
        getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetAllProfilesLookupsByUserCode(requestModel: requestModel) {[weak self] result in
                self?.getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    if !success.isEmpty {
                        for watchlist in success {
                            if watchlist.profileName == "fav" {
                                UserDefaultController().profileID = watchlist.profileID
                                self?.callGetMarketWatchByProfileIDAPI()
                                break
                            }
                        }
                    }
                    
                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func callGetMarketWatchByProfileIDAPI() {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.marketWatchData?.removeAll()
                    self?.topGainerData?.removeAll()
                    self?.topLoserData?.removeAll()
                    self?.mostActiveData?.removeAll()
                    
                    self?.marketWatchData = success
                    
                    self?.topGainerData?.append(contentsOf: success.filter({ $0.netChangePerc?.contains("-") == false && $0.netChangePerc != "0" }))
                    self?.topLoserData?.append(contentsOf: success.filter({ $0.netChangePerc?.contains("-") == true }))
                    self?.mostActiveData?.append(contentsOf: success.filter({ $0.executed != "0" || $0.executed != "" }))

                    self?.tempMarketWatchData = self?.marketWatchData
                    self?.tempTopGainerData = self?.topGainerData
                    self?.tempTopLoserData = self?.topLoserData
                    self?.tempMostActiveData = self?.mostActiveData
                    
                    self?.SubscribeMarketWatchSymbolsSignalR()

                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
               
                }
            }
        }

    }
    
    func callExchangeSummaryAPI() {
        let requestModel = GetExchangeSummaryRequestModel()
        
        getExchangeSummaryAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetExchangeSummary(requestModel: requestModel) {[weak self] result in
                self?.getExchangeSummaryAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getExchangeSummaryAPIResult = .onSuccess(response: success)
                    
                    self?.exchangeSummaryData = success
                    UserDefaultController().exchangeID = success.first?.exchangeID ?? ""
                    
                case .failure(let failure):
                        self?.getExchangeSummaryAPIResult = .onFailure(error: failure)
                    debugPrint("Overview failure: \(failure)")
                }
            }
        }
    }
}

// MARK: SignalR
extension FavoriteViewModel {
    func SubscribeMarketWatchSymbolsSignalR() {
        if marketWatchData?.count ?? 0 <= 0 {return}

        var arraySymbols: [String] = []
        
        for i in 0...(marketWatchData?.count ?? 0) - 1 {
            arraySymbols.append(marketWatchData?[i].symbol ?? "")
        }
        
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
    //        debugPrint("Username sent SignalR: \(KeyChainController().username ?? "")")
    //        debugPrint("symbols sent SignalR: \(arraySymbols)")

        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke subscribeMarketWatchSymbols '\(arraySymbols)'")

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.subscribeMarketWatchSymbols.rawValue, arguments: [KeyChainController().username ?? "", arraySymbols]) { (result, error) in
                    if let e = error {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(arraySymbols)' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

                    } else {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(arraySymbols)' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                printToLog("SubscribeMarketWatchSymbols chatHub '\(arraySymbols)' error: \(error.localizedDescription)")
                self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

            }
        } else {
            debugPrint("Chathub is nil")
        }
    }

    func UnSubscribleMarketWatchSymbolsSignalR(){
        if marketWatchData?.count ?? 0 <= 0 {return}
        
        var arraySymbols: [String] = []
        
        for i in 0...(marketWatchData?.count ?? 0) - 1 {
            arraySymbols.append(marketWatchData?[i].symbol ?? "")
        }
        
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke unSubscribeMarketWatchSymbols '\(arraySymbols)'")

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.unSubscribeMarketWatchSymbols.rawValue, arguments: [KeyChainController().username ?? ""]) { (result, error) in
                    if let e = error {
                        printToLog("unSubscribeMarketWatchSymbols invoke '\(arraySymbols)' Error: \(e)")
                    } else {
                        printToLog("unSubscribeMarketWatchSymbols invoke '\(arraySymbols)' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                    }
                }
            } catch let error {
                printToLog("unSubscribeMarketWatchSymbols chatHub '\(arraySymbols)' error: \(error.localizedDescription)")
            }
        }
    }

}

// MARK: Delegates
extension FavoriteViewModel:WatchlistFilterDelegate {
    func onFilterChange(filter: [FilterCategoryModel], specificShareTypes: SpecificShareTypes, sectorTypes: SectorTypes) {
        specificShareFilter = specificShareTypes
        sectorTypeFilter = sectorTypes
        categoryFilter = filter
        
        filterData()
    }
}

extension FavoriteViewModel: MarketWatchDelegate {
    func onSubscribeMDSymbol(data: SubscribeMarketWatchSymbolsUIModel) {
        
    }
    
    func onWatchlistDataReceive(data: GetMarketWatchByProfileIDUIModel) {
        for (index, listItem) in (marketWatchData ?? []).enumerated() {
            if listItem.symbol == data.symbol {
                
                marketWatchData?[index].offerVolume = data.offerVolume
                marketWatchData?[index].offerPrice = data.offerPrice
                marketWatchData?[index].lastTradePrice = data.lastTradePrice
                marketWatchData?[index].bidPrice = data.bidPrice
                marketWatchData?[index].bidVolume = data.bidVolume
                marketWatchData?[index].netChangePerc = data.netChangePerc
                marketWatchData?[index].netChange = data.netChange
                marketWatchData?[index].totalValue = data.totalValue
                marketWatchData?[index].totalVolume = data.totalVolume
                marketWatchData?[index].executed = data.executed
                marketWatchData?[index].openPrice = data.openPrice
                marketWatchData?[index].closePrice = data.closePrice
                marketWatchData?[index].lowPrice = data.lowPrice
                marketWatchData?[index].highPrice = data.highPrice
                marketWatchData?[index].wk52Low = data.wk52Low
                marketWatchData?[index].wk52High = data.wk52High
                
                
                if (data.netChangePerc?.contains("-") == false && data.netChangePerc != "0") {
                    // Add Top Gainer
                    if let index = self.topGainerData?.firstIndex(where: {$0.symbol == data.symbol}) {
                        self.topGainerData?[index].offerVolume = data.offerVolume
                        self.topGainerData?[index].offerPrice = data.offerPrice
                        self.topGainerData?[index].lastTradePrice = data.lastTradePrice
                        self.topGainerData?[index].bidPrice = data.bidPrice
                        self.topGainerData?[index].bidVolume = data.bidVolume
                        self.topGainerData?[index].netChangePerc = data.netChangePerc
                        self.topGainerData?[index].netChange = data.netChange
                        self.topGainerData?[index].totalValue = data.totalValue
                        self.topGainerData?[index].totalVolume = data.totalVolume
                        self.topGainerData?[index].executed = data.executed
                        self.topGainerData?[index].openPrice = data.openPrice
                        self.topGainerData?[index].closePrice = data.closePrice
                        self.topGainerData?[index].lowPrice = data.lowPrice
                        self.topGainerData?[index].highPrice = data.highPrice
                        self.topGainerData?[index].wk52Low = data.wk52Low
                        self.topGainerData?[index].wk52High = data.wk52High
                        
                    } else {
                        self.topGainerData?.append(data)
                    }
                } else {
                    // Remove Top Gainer
                    if let index = self.topGainerData?.firstIndex(where: {$0.symbol == data.symbol}) {
                        self.topGainerData?.remove(at: index)
                    }
                }
    
                if (data.netChangePerc?.contains("-") == true) {
                    // Add Top Loser
                    if let index = self.topLoserData?.firstIndex(where: {$0.symbol == data.symbol}) {
                        self.topLoserData?[index].offerVolume = data.offerVolume
                        self.topLoserData?[index].offerPrice = data.offerPrice
                        self.topLoserData?[index].lastTradePrice = data.lastTradePrice
                        self.topLoserData?[index].bidPrice = data.bidPrice
                        self.topLoserData?[index].bidVolume = data.bidVolume
                        self.topLoserData?[index].netChangePerc = data.netChangePerc
                        self.topLoserData?[index].netChange = data.netChange
                        self.topLoserData?[index].totalValue = data.totalValue
                        self.topLoserData?[index].totalVolume = data.totalVolume
                        self.topLoserData?[index].executed = data.executed
                        self.topLoserData?[index].openPrice = data.openPrice
                        self.topLoserData?[index].closePrice = data.closePrice
                        self.topLoserData?[index].lowPrice = data.lowPrice
                        self.topLoserData?[index].highPrice = data.highPrice
                        self.topLoserData?[index].wk52Low = data.wk52Low
                        self.topLoserData?[index].wk52High = data.wk52High
                        
                    } else {
                        self.topLoserData?.append(data)
                    }
                } else {
                    // Remove Top Loser
                    if let index = self.topLoserData?.firstIndex(where: {$0.symbol == data.symbol}) {
                        self.topLoserData?.remove(at: index)
                    }
                }
    
                if (listItem.executed != "0" || listItem.executed != "") {
                    // Add Most Active
                    if let index = self.mostActiveData?.firstIndex(where: {$0.symbol == data.symbol}) {
                        self.mostActiveData?[index].offerVolume = data.offerVolume
                        self.mostActiveData?[index].offerPrice = data.offerPrice
                        self.mostActiveData?[index].lastTradePrice = data.lastTradePrice
                        self.mostActiveData?[index].bidPrice = data.bidPrice
                        self.mostActiveData?[index].bidVolume = data.bidVolume
                        self.mostActiveData?[index].netChangePerc = data.netChangePerc
                        self.mostActiveData?[index].netChange = data.netChange
                        self.mostActiveData?[index].totalValue = data.totalValue
                        self.mostActiveData?[index].totalVolume = data.totalVolume
                        self.mostActiveData?[index].executed = data.executed
                        self.mostActiveData?[index].openPrice = data.openPrice
                        self.mostActiveData?[index].closePrice = data.closePrice
                        self.mostActiveData?[index].lowPrice = data.lowPrice
                        self.mostActiveData?[index].highPrice = data.highPrice
                        self.mostActiveData?[index].wk52Low = data.wk52Low
                        self.mostActiveData?[index].wk52High = data.wk52High
                        
                    } else {
                        self.mostActiveData?.append(data)
                    }
                } else {
                    // Remove Most Active
                    if let index = self.mostActiveData?.firstIndex(where: {$0.symbol == data.symbol}) {
                        self.mostActiveData?.remove(at: index)
                    }
                }
                
                updatedSymbol = data.symbol

            }
        }
    }
}

extension FavoriteViewModel: ConnectionDelegate {
    func onSendExchangeMarketObject(data: [GetExchangeSummaryUIModel]) {
        let market = data.filter({$0.exchangeID?.lowercased() == "qe"}).first
        UserDefaultController().isMarketOpen = market?.statusCode == "0002" || market?.statusCode == "0003" ? "true" : "false"

        for (index, item) in (exchangeSummaryData ?? []).enumerated() {
            if let match = data.first(where: { $0.isinCode == item.indexCode }) {
                if match.turnOver?.isEmpty == false {exchangeSummaryData?[index].turnOver = match.turnOver}
                if match.currentValue?.isEmpty == false  {exchangeSummaryData?[index].currentValue = match.currentValue}
                if match.netChange?.isEmpty == false {exchangeSummaryData?[index].netChange = match.netChange}
                if match.netChangePerc?.isEmpty == false {exchangeSummaryData?[index].netChangePerc = match.netChangePerc}
                if match.statusCode?.isEmpty == false {exchangeSummaryData?[index].statusCode = match.statusCode}
                
                // Handled in Coonection_Hub
//                self.filterMarketStatus()
            }
        }
    }
}
