//
//  MarketSummaryViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation

class IndustrialSectorViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol

    @Published var industrialSectorData: GetMarketIndiciesUIModel?
    
    @Published var chartLoaded: Bool?

    @Published var getMarketIndiciesAPIResult:APIResultType<[GetMarketIndiciesUIModel]>?
    @Published var sendMarketIndexObjectAPIResult:APIResultType<[SendMarketIndexObjectUIModel]>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase

        chartLoaded = false
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func onExploreCompaniesTap() {
        coordinator.openIndustrialCompaniesScene(delegate: self)
    }
}

extension IndustrialSectorViewModel: IndustrialCompaniesDelegate {
    func onSelect() {
        
    }
}

// MARK: Routing
extension IndustrialSectorViewModel {
    
}

// MARK: API Calls
extension IndustrialSectorViewModel {
    func callGetMarketIndiciesAPI(succecss: Bool) {
        let requestModel = GetMarketIndiciesRequestModel()
        
        getMarketIndiciesAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetMarketIndicies(requestModel: requestModel) {[weak self] result in
                self?.getMarketIndiciesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketIndiciesAPIResult = .onSuccess(response: success)
                    self?.industrialSectorData = success.filter({$0.CI_SECTOR == "0003"}).first
                    self?.SendMarketIndexObject()
                case .failure(let failure):
                    self?.getMarketIndiciesAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
}

// MARK: SignalR
extension IndustrialSectorViewModel {
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
extension IndustrialSectorViewModel: SendMarketIndexObjectDelegate {
    func MarketIndexObjectReceived(data: SendMarketIndexObjectUIModel) {
        if data.sector == "0003" {
            industrialSectorData?.CI_CURRENT_INDEX = data.currentValue
            industrialSectorData?.CI_CHG_INDEX = data.netChange
            industrialSectorData?.CI_CHG_PERC_INDEX = data.netChangePerc
        }
    }
}
