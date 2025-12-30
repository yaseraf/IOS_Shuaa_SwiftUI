//
//  AddAlertViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
class AddAlertViewModel: ObservableObject {
    private let coordinator: GenericCoordinatorProtocol
    private let useCase: MenuUseCaseProtocol
    
    @Published var selectedShare: GetCompaniesLookupsUIModel?
    @Published var selectedPriceFactor: PriceFactorUIModel?
    @Published var selectedCriteria: PriceFactorUIModel?
    @Published var shareValue: String
    @Published var selectedExpiryTime: String?
    @Published var alertData:AddAlertsUIModel?
    
    @Published var addAlertAPIResult:APIResultType<AddAlertsUIModel>?

    init(coordinator: GenericCoordinatorProtocol, useCase: MenuUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        selectedShare = .testUIModel()
        selectedPriceFactor = .initializer()
        shareValue = ""
        selectedExpiryTime = ""
    }
}

// MARK: Routing
extension AddAlertViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func onAddTap() {
        addAlertAPI(success: true)
    }
    
    func openSelectSharesScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectSharesScene(delegate: self)
    }
    
    func openSelectPriceFactorScene(alertCondition: AlertCondition, selectedCategory: PriceFactorUIModel) {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPriceFactorScene(delegate: self, alertCondition: alertCondition, selectedCategory: selectedCategory)
    }
    
    func openSelectExpiryTimeScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openRangeCalendarScene(delegate: self, title: "expiry_date".localized, isMultiSelect: false)
    }
}

// MARK: API Calls
extension AddAlertViewModel {
    func addAlertAPI(success:Bool) {
        let requestModel = AddAlertsRequestModel()
        addAlertAPIResult = .onLoading(show: true)
        
        UserDefaultController().alertCondition = "E"
        UserDefaultController().alertConditionValue = shareValue
        UserDefaultController().alertConditionName = selectedPriceFactor?.factorId
        UserDefaultController().alertCriteria = selectedCriteria?.factorId
        UserDefaultController().alertName = ""
        UserDefaultController().notificationAction = "Only_Once"
        UserDefaultController().alertValidity = convertDateFormat(selectedExpiryTime ?? "")
        
        Task.init {
            await useCase.AddAlerts(requestModel: requestModel) {[weak self] result in
                self?.addAlertAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.addAlertAPIResult = .onSuccess(response: success)
                    self?.alertData = success
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "create_alert_success".localized)
//                    self?.alertAddDelegate.onAdd()
                    self?.coordinator.popViewController()
                    self?.coordinator.dismiss()
                    debugPrint("add alert success: ")
                    
                case .failure(let failure):
                        self?.addAlertAPIResult = .onFailure(error: failure)
                    debugPrint("add alert failure: \(failure)")
                }
            }
        }
    }
}

// MARK: Functions
extension AddAlertViewModel {
    func convertDateFormat(_ input: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = inputFormatter.date(from: input) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "ddMMyyyy"
        
        return outputFormatter.string(from: date)
    }
}

// MARK: Delegates
extension AddAlertViewModel: SelectSharesDelegate {
    func onSelect(share: GetCompaniesLookupsUIModel?) {
        selectedShare = share
        UserDefaultController().selectedSymbol = share?.symbol
    }
}

extension AddAlertViewModel: SelectPriceFactorDelegate {
    func onSelect(factor: PriceFactorUIModel, alertCondition: AlertCondition) {
        if alertCondition == .priceFactor {
            selectedPriceFactor = factor
        } else {
            selectedCriteria = factor
        }
    }
}

extension AddAlertViewModel: RangeCalendarDelegate {
    func onSelect(selectedDateFrom: Date?, selectedDateTo: Date?) {
        selectedExpiryTime = selectedDateFrom?.toString(dateFormat: .ddMMyyyy)
    }
}
