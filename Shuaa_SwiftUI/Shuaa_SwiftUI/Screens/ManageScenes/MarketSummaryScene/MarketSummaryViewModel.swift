//
//  MarketSummaryViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation

class MarketSummaryViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var marketSummaryData: [GetMarketIndiciesUIModel]?
    
    @Published var getMarketIndiciesAPIResult:APIResultType<[GetMarketIndiciesUIModel]>?
    @Published var sendMarketIndexObjectAPIResult:APIResultType<[SendMarketIndexObjectUIModel]>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        Connection_Hub.shared.sendMarketIndexObjectDelegate = self
        
        marketSummaryData = []
    }
}

// MARK: Mock Data
extension MarketSummaryViewModel {
    func getMarketSummaryData() {
//        var data: [MarketSummaryUIModel] = []
//
//        data.append(MarketSummaryUIModel(companyNameEn: "General Index", companyNameAr: "المؤشر العام", value: 10571.09, change: 83.47, changePerc: 0.765))
//        data.append(MarketSummaryUIModel(companyNameEn: "All Shares", companyNameAr: "جميع الأسهم", value: 1798.69, change: -0.890, changePerc: -0.050))
//        data.append(MarketSummaryUIModel(companyNameEn: "Total Income", companyNameAr: "العائد الإجمالي", value: 3775.48, change: 28.81, changePerc: 0.769))
//        data.append(MarketSummaryUIModel(companyNameEn: "Telecoms", companyNameAr: "قطاع الاتصالات", value: 1627.29, change: 0.00, changePerc: 0.00))
//        data.append(MarketSummaryUIModel(companyNameEn: "Transportation", companyNameAr: "قطاع النقل", value: 5164.69, change: 56.27, changePerc: 1.102))
//        data.append(MarketSummaryUIModel(companyNameEn: "Real Estate", companyNameAr: "قطاع العقارات", value: 1616.41, change: -5.260, changePerc: -0.324))
//        data.append(MarketSummaryUIModel(companyNameEn: "Banks&Financial Sector", companyNameAr: "قطاع العقارات", value: 4735.93, change: 50.57, changePerc: 1.079))
//        data.append(MarketSummaryUIModel(companyNameEn: "Industrials", companyNameAr: "قطاع العقارات", value: 4246.42, change: 22.61, changePerc: 0.535))
//        data.append(MarketSummaryUIModel(companyNameEn: "Insurance", companyNameAr: "قطاع التأمين", value: 2348.50, change: 6.590, changePerc: 0.281))
//        data.append(MarketSummaryUIModel(companyNameEn: "Consumer goods and services", companyNameAr: "قطاع البضائع و الخدمات الإستهلاكية", value: 7666.76, change: 13.73, changePerc: 0.179))
//
//        marketSummaryData = data
    }
}

// MARK: Routing
extension MarketSummaryViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
}

//MARK: API Calls
extension MarketSummaryViewModel {
    func callGetMarketIndiciesAPI(succecss: Bool) {
        let requestModel = GetMarketIndiciesRequestModel()
        
        getMarketIndiciesAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetMarketIndicies(requestModel: requestModel) {[weak self] result in
                self?.getMarketIndiciesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketIndiciesAPIResult = .onSuccess(response: success)
                    self?.marketSummaryData = success
                    self?.SendMarketIndexObject()
                case .failure(let failure):
                    self?.getMarketIndiciesAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
}

// MARK: SignalR
extension MarketSummaryViewModel {
    func SendMarketIndexObject() {
        
        self.sendMarketIndexObjectAPIResult = .onLoading(show:  true)

        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke SendMarketIndexObject")

                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendMarketIndexObject.rawValue, arguments: [UserDefaultController().exchangeID ?? "", KeyChainController().username ?? ""]) { (result, error) in
                    if let e = error {
                        debugPrint("SendMarketIndexObject invoke Error: \(e)")
                        self.sendMarketIndexObjectAPIResult = .onLoading(show:  false)

                    } else {
                        debugPrint("SendMarketIndexObject invoke Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.sendMarketIndexObjectAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                debugPrint("SendMarketIndexObject chatHub error: \(error.localizedDescription)")
                self.sendMarketIndexObjectAPIResult = .onLoading(show:  false)

            }
        } else {
            debugPrint("Chathub is nil")
        }
    }
}

// MARK: Delegates
extension MarketSummaryViewModel: SendMarketIndexObjectDelegate {
    func MarketIndexObjectReceived(data: SendMarketIndexObjectUIModel) {
        if let index = marketSummaryData?.firstIndex(where: { $0.CI_SECTOR == data.sector }), var existing = marketSummaryData?[index] {
            existing.CI_CURRENT_INDEX = data.currentValue
            existing.CI_CHG_INDEX = data.netChange
            existing.CI_CHG_PERC_INDEX = data.netChangePerc
            
            marketSummaryData?[index] = existing
        }

    }
}
