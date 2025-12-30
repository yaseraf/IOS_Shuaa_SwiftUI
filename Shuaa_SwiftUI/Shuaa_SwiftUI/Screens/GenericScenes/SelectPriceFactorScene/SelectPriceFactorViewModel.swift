//
//  SelectPriceFactorViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
class SelectPriceFactorViewModel: ObservableObject {
    
    private let coordinator: GenericCoordinatorProtocol
    let delegate: SelectPriceFactorDelegate?
    
    @Published var priceFactors: [PriceFactorUIModel]?
    @Published var listCriterias: [PriceFactorUIModel]?
    
    @Published var alertCondition: AlertCondition?
    @Published var selectedPriceFactor: PriceFactorUIModel?
    @Published var selectedCriteria: PriceFactorUIModel?
    
    init(coordinator: GenericCoordinatorProtocol, delegate: SelectPriceFactorDelegate, alertCondition: AlertCondition, selectedCategory: PriceFactorUIModel) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.alertCondition = alertCondition
        priceFactors = []
        listCriterias = []
        
        if alertCondition == .priceFactor {
            getPriceFactors()
            selectedPriceFactor = selectedCategory
        } else {
            getListCriteria()
            selectedCriteria = selectedCategory
        }
    }
    
    func getPriceFactors() {
        var data: [PriceFactorUIModel] = []
        data.append(PriceFactorUIModel(factorId: "MW_HIGH_PRICE", factorName: "the_highest_price".localized))
        data.append(PriceFactorUIModel(factorId: "MW_LAST_TRADE_PRICE", factorName: "last_price".localized))
        data.append(PriceFactorUIModel(factorId: "MW_AVERAGE_PRICE", factorName: "average_price".localized))
        data.append(PriceFactorUIModel(factorId: "MW_TOTAL_VOLUME", factorName: "total_quantity".localized))
        data.append(PriceFactorUIModel(factorId: "MW_LOW_PRICE", factorName: "lower_price".localized))
        priceFactors = data
    }
    
    func getListCriteria() {
        var data: [PriceFactorUIModel] = []
        data.append(PriceFactorUIModel(factorId: "E", factorName: "equal".localized))
        data.append(PriceFactorUIModel(factorId: "NE", factorName: "not_equal".localized))
        data.append(PriceFactorUIModel(factorId: "GT", factorName: "greater_than".localized))
        data.append(PriceFactorUIModel(factorId: "GE", factorName: "greater_and_equal".localized))
        data.append(PriceFactorUIModel(factorId: "LT", factorName: "less_than".localized))
        data.append(PriceFactorUIModel(factorId: "LE", factorName: "less_and_equal".localized))
        listCriterias = data
    }
    
    
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func onConfirm(factor: PriceFactorUIModel) {
        delegate?.onSelect(factor: factor, alertCondition: alertCondition ?? .priceFactor)
        coordinator.dismiss()
    }
}
