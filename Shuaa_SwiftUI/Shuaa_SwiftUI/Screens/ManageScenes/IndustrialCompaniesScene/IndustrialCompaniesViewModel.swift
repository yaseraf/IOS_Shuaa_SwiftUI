//
//  MarketSummaryViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation

class IndustrialCompaniesViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    private let delegate: IndustrialCompaniesDelegate
    
    @Published var industrialCompaniesData:[GetMarketWatchBySectorIDUIModel]?

    @Published var getMarketWatchBySectorIDAPIResult:APIResultType<[GetMarketWatchBySectorIDUIModel]>?
    
    init(coordinator: ManageCoordinatorProtocol, delegate: IndustrialCompaniesDelegate, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.useCase = useCase
        
        industrialCompaniesData = []
    }
}

// MARK: Mock Data
extension IndustrialCompaniesViewModel {
    func getCompaniesData() {
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
//        data.append(HomePortfolioUIModel(stockId: 5, image: "ic_DUBK", name: "DUBK", fullNameE: "Dukhan Bank", fullNameN: "بنك دخان", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: -1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 6, image: "ic_QIB", name: "QIB", fullNameE: "AlMaref", fullNameN: "المصرف", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        data.append(HomePortfolioUIModel(stockId: 7, image: "ic_QATI", name: "QATI", fullNameE: "Qatar Insurance Group", fullNameN: "مجموعة قطر للتأمين", volume: 500, offer: 17.29, lastPrice: 17.29, bid: 500000, change: 0.12, changePerc: 1.75, trades: 1425, tradesValue: 3530339.87, tradesVolume: 1247938, acceptedTrades: 168, companyMarketValue: 154155992833.30, valueQAR: 56330783.58, openPrice: 2840, closePrice: 2830, previousPrice: 0.02, downPrice: 2819, upPrice: 2843, currentPrice: 16.82, todayHigh: 2843, todayLow: 2819, offerVolume: 143842, offerPrice: 16.82, bidVolume: 16.80, bidPrice: 225000, wk52High: 3180, wk52Low: 2577))
//        
//        industrialCompaniesData = data
//        
        
    }

}

// MARK: Routing
extension IndustrialCompaniesViewModel {
    
    func onBackTap() {
        coordinator.dismiss()
    }

    func onCompanySelect() {
        delegate.onSelect()
        coordinator.dismiss()
    }
}

// MARK: API Calls
extension IndustrialCompaniesViewModel {
    func callGetMarketWatchBySectorIDAPI(succecss: Bool) {
        let requestModel = GetMarketWatchBySectorIDRequestModel(sectorID: "0003", webCode: KeyChainController().webCode ?? "")
        
        getMarketWatchBySectorIDAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetMarketWatchBySectorID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchBySectorIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchBySectorIDAPIResult = .onSuccess(response: success)
                    self?.industrialCompaniesData = success
                case .failure(let failure):
                    self?.getMarketWatchBySectorIDAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
}
