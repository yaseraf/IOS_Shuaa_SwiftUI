//
//  MarketDealsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
class MarketDealsViewModel: ObservableObject {
    private let coordinator: ManageCoordinator
    
    @Published var portfolioData: [GetPortfolioUIModel]?
    @Published var marketDealsData: [GetMarketTimeSaleUIModel]?

    var fromSequence: Int = -1
    var toSequence: Int = 200

    @Published var getMarketTimeSaleAPIResult:APIResultType<[GetMarketTimeSaleUIModel]>?

    init(coordinator: ManageCoordinator) {
        self.coordinator = coordinator
        
        Connection_Hub.shared.marketTimeSaleDelegate = self
    }
}

// MARK: Routing
extension MarketDealsViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
}

// MARK: Mock Data
extension MarketDealsViewModel {
    func getMarketDealsData() {
//        var data: [MarketDealsUIModel] = []
//        
//        data.append(MarketDealsUIModel(image: "ic_QNBK", name: "QNBK", fullNameA: "بنك القطري", fullNameE: "QNB", date: "2025-02-12", time: "10:34 AM", change: -0.004, changePerc: -0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        data.append(MarketDealsUIModel(image: "ic_ABQK", name: "Ahli Bank", fullNameA: "بنك الأهلي", fullNameE: "ABQK", date: "2025-02-12", time: "10:34 AM", change: 0.004, changePerc: 0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        data.append(MarketDealsUIModel(image: "ic_DOHI", name: "Doha Insurance", fullNameA: "مجموعة الدوحة للتأمين", fullNameE: "DOHI", date: "2025-02-12", time: "10:34 AM", change: -0.004, changePerc: -0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        data.append(MarketDealsUIModel(image: "ic_DUBK", name: "Dukhan Bank", fullNameA: "بنك دخان", fullNameE: "DUBK", date: "2025-02-12", time: "10:34 AM", change: 0.004, changePerc: 0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        data.append(MarketDealsUIModel(image: "ic_QIB", name: "Qatar Islamic Bank", fullNameA: "المصرف", fullNameE: "QIBK", date: "2025-02-12", time: "10:34 AM", change: 0.004, changePerc: 0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        data.append(MarketDealsUIModel(image: "ic_QNBK", name: "QNBK", fullNameA: "بنك القطري", fullNameE: "QNB", date: "2025-02-12", time: "10:34 AM", change: -0.004, changePerc: -0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        data.append(MarketDealsUIModel(image: "ic_ABQK", name: "Ahli Bank", fullNameA: "بنك الأهلي", fullNameE: "ABQK", date: "2025-02-12", time: "10:34 AM", change: 0.004, changePerc: 0.30, quantity: 10000, value: 13330.00, price: 1.333))
//        
//        marketDealsData = data
    }

}

// MARK: API Calls
extension MarketDealsViewModel {
    
}

// MARK: SignalR
extension MarketDealsViewModel {
    func GetMarketTimeSaleSignalR() {
        if Connection_Hub.shared.chatHub != nil {
            do {
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.getMarketTradesFullObject.rawValue, arguments: [UserDefaultController().exchangeID ?? "", fromSequence, toSequence]) { (result, error) in
                    if let e = error {
                        printToLog("SignalR getMarketTimeSale invoke Error: \(e)")
                        self.getMarketTimeSaleAPIResult = .onLoading(show:  false)

                    } else {
                        printToLog("SignalR getMarketTimeSale invoke Success! - result: \(result)")
                        self.getMarketTimeSaleAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                printToLog("SignalR getMarketTimeSale chatHub error: \(error.localizedDescription)")
                self.getMarketTimeSaleAPIResult = .onLoading(show:  false)
            }
        } else {
            debugPrint("Chathub is nil")
        }
    }
}

// MARK: Delegate
extension MarketDealsViewModel:MarketTimeSaleDelegate {
    func onMarketTimeSaleReceive(data: [GetMarketTimeSaleUIModel]) {
        marketDealsData = data
    }
}
