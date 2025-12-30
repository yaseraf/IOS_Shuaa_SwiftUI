//
//  TradeIndexViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation

class TradeIndexViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol

    @Published var exchangeSummaryData: GetExchangeSummaryUIModel?
    @Published var chartLoaded: Bool?

    @Published var getExchangeSummaryAPIResult:APIResultType<[GetExchangeSummaryUIModel]>?
    @Published var lastUpdateTime: String?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        Connection_Hub.shared.connectionDelegate = self
        
        chartLoaded = false
    }
}

// MARK: Routing
extension TradeIndexViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension TradeIndexViewModel {
    func callExchangeSummaryAPI() {
        let requestModel = GetExchangeSummaryRequestModel()
        
        getExchangeSummaryAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetExchangeSummary(requestModel: requestModel) {[weak self] result in
                self?.getExchangeSummaryAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getExchangeSummaryAPIResult = .onSuccess(response: success)
                    
                    self?.exchangeSummaryData = success.filter({$0.exchangeID == "QE"}).first
                    UserDefaultController().exchangeID = success.first?.exchangeID ?? ""
                    
                case .failure(let failure):
                        self?.getExchangeSummaryAPIResult = .onFailure(error: failure)
                    debugPrint("Overview failure: \(failure)")
                }
            }
        }
    }

}

// MARK: Delegate
extension TradeIndexViewModel:ConnectionDelegate {
    func onSendExchangeMarketObject(data: [GetExchangeSummaryUIModel]) {
        let market = data.filter({$0.exchangeID?.lowercased() == "qe"}).first
        UserDefaultController().isMarketOpen = market?.statusCode == "0002" || market?.statusCode == "0003" ? "true" : "false"
        
        lastUpdateTime = Date().toString(dateFormat: .HHmmss_ddMMyyyy)
        
        if let match = data.first(where: { $0.exchangeID == "QE" }) {
            if match.turnOver?.isEmpty == false {exchangeSummaryData?.turnOver = match.turnOver}
            if match.currentValue?.isEmpty == false  {exchangeSummaryData?.currentValue = match.currentValue}
            if match.netChange?.isEmpty == false {exchangeSummaryData?.netChange = match.netChange}
            if match.netChangePerc?.isEmpty == false {exchangeSummaryData?.netChangePerc = match.netChangePerc}
            if match.statusCode?.isEmpty == false {exchangeSummaryData?.statusCode = match.statusCode}
            if match.symbolsTraded?.isEmpty == false {exchangeSummaryData?.symbolsTraded = match.symbolsTraded}
            if match.volume?.isEmpty == false {exchangeSummaryData?.volume = match.volume}
            if match.symbolsUP?.isEmpty == false {exchangeSummaryData?.symbolsUP = match.symbolsUP}
            if match.symbolsDown?.isEmpty == false {exchangeSummaryData?.symbolsDown = match.symbolsDown}
            if match.symbolsUnChange?.isEmpty == false {exchangeSummaryData?.symbolsUnChange = match.symbolsUnChange}
            
            // Handled in Coonection_Hub
//                self.filterMarketStatus()
        }
    }
}
