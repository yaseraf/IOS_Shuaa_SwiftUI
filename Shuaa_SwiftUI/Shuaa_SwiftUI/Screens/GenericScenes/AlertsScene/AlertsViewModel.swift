//
//  AlertsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
class AlertsViewModel: ObservableObject {
    private let coordinator: GenericCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol

    @Published var alertsData: [GetAlertByUserCodeUIModel]?
    @Published var notificationsData:[NotificationUIModel]?
    @Published var listParameter:[ItemPickerModelType] = []

    @Published var getAllPushNotificationsByUserAPIResult:APIResultType<[NotificationUIModel]>?
    @Published var getAlertsByUserCodeAPIResult:APIResultType<[GetAlertByUserCodeUIModel]>?

    init(coordinator: GenericCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        alertsData = []
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openAddAlertsScene() {
        coordinator.openAddAlertScene()
    }
    
    func getAlertsData() {
//        var data: [AlertsUIModel] = []
//        data.append(AlertsUIModel(image: "ic_qnbLogo", fullNameEn: "Qatar National Bank", fullNameAr: "بنك قطر الوطني", symbol: "QNB", date: "04-12-2025", value: 1500, alertNo: 4, priceFactor: "avg", state: "new"))
//        
//        alertsData = data
    }
}


// MARK: API Calls
extension AlertsViewModel {
    func getAllPushNotificationsByUserAPI(success: Bool) {
        let requestModel = GetAllPushNotificationsByUserRequestModel()
        getAllPushNotificationsByUserAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getAllPushNotificationsByUser(requestModel: requestModel) {[weak self] result in
                self?.getAllPushNotificationsByUserAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                        self?.getAllPushNotificationsByUserAPIResult = .onSuccess(response: success)
                    
                    self?.notificationsData = success
                    
                case .failure(let failure):
                        self?.getAllPushNotificationsByUserAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func getAlertsByUserCodeAPI(success: Bool) {
        let requestModel = GetAlertByUserCodeRequestModel()
        getAlertsByUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getAlertByUserCode(requestModel: requestModel) {[weak self] result in
                self?.getAlertsByUserCodeAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                        
                    self?.getAlertsByUserCodeAPIResult = .onSuccess(response: success)
                    
                    self?.alertsData = success
                    debugPrint("alerts success")
                    
                    for i in 0..<(self?.alertsData?.count ?? 0) {
                        if let parameter = self?.listParameter.filter({ $0.key ==  self?.alertsData?[i].conditionName ?? ""}) {
                            self?.alertsData?[i].conditionName = parameter.first?.name
                        }
                    }
                    
                case .failure(let failure):
                        self?.getAlertsByUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("alerts failure")

                }
            }
        }
    }

}

// MARK: Functions
extension AlertsViewModel {
    func getListParameter(){
        var list:[ItemPickerUIModel] = []
        list.append(.init(key: "MW_HIGH_PRICE" ,name: "High Price"))
        list.append(.init(key: "MW_LAST_TRADE_PRICE" ,name: "Last Trade Price"))
        list.append(.init(key: "MW_AVERAGE_PRICE" ,name: "Average Price"))
        list.append(.init(key: "MW_TOTAL_VOLUME" ,name: "Total Volume"))
        list.append(.init(key: "MW_LOW_PRICE" ,name: "Low Price"))
        list.append(.init(key: "MW_LAST_TRADE_VOL" ,name: "Last Trade Volume"))
        list.append(.init(key: "MW_NET_CHANGE" ,name: "Net Change"))
        list.append(.init(key: "Net_Change_per" ,name: "Net Change per"))
        list.append(.init(key: "MW_CLOSING_PRICE" ,name: "Closing Price"))
        list.append(.init(key: "MW_OPENING_PRICE" ,name: "Opening Price"))
        list.append(.init(key: "MW_MAX_PRICE" ,name: "Max Price"))
        list.append(.init(key: "MW_MIN_PRICE" ,name: "Min Price"))
        list.append(.init(key: "MW_VOLUME_AVG" ,name: "Volume Average"))
        list.append(.init(key: "MW_OFFER_PRICE" ,name: "Offer Price"))
        list.append(.init(key: "MW_BID_PRICE" ,name: "Bid Price"))
        list.append(.init(key: "MW_VALUE" ,name: "Total Value"))
        listParameter = list
    }
}
