//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class QuantityCalculatorViewModel: ObservableObject {
    private var coordinator: TradeCoordinatorProtocol
    private let delegate: QuantityCalculatorDelegate
    private var useCase: TradeUseCaseProtocol
    
    @Published var calculateSharesAPIResult:APIResultType<String>?
    
    @Published var calculatedShares: String?
    @Published var lastTradePrice: String?
    
    init(coordinator: TradeCoordinatorProtocol, useCase: TradeUseCaseProtocol, delegate: QuantityCalculatorDelegate, lastTradePrice: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.delegate = delegate
        self.lastTradePrice = lastTradePrice
        
        calculatedShares = "0"
    }
}

// Routing
extension QuantityCalculatorViewModel {
    
    func onCalculate(amount: String) {
        UserDefaultController().cash = amount
        callCalculatesSharesAPI()
    }
    
    func onDismiss() {
        delegate.onCalculate(amount: calculatedShares ?? "")
        coordinator.dismiss()
    }

}

// API Calls
extension QuantityCalculatorViewModel {
    func callCalculatesSharesAPI() {
        let requestModel = CalculatesSharesRequestModel()
                
        calculateSharesAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.CalculatesShares(requestModel: requestModel) {[weak self] result in
                self?.calculateSharesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.calculatedShares = success
                    
                    self?.calculateSharesAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.calculateSharesAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}
