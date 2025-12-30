//
//  NotificationsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
class NotificationsViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: MenuUseCaseProtocol
    
    @Published var alertsData: [GetAlertByUserCodeUIModel]?
    
    @Published var getAlertUserCodeAPIResult:APIResultType<[GetAlertByUserCodeUIModel]>?
    
    init(coordinator: ManageCoordinatorProtocol, useCase: MenuUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        self.alertsData = []
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
}

// MARK: Routing
extension NotificationsViewModel {
    func openAddAlertScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openAddAlertScene()
    }
}

// MARK: API Calls
extension NotificationsViewModel {
    func callGetAlertByUserCodeAPI() {
        let requestModel = GetAlertByUserCodeRequestModel()
        
        getAlertUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getAlertByUserCode(requestModel: requestModel) {[weak self] result in
                self?.getAlertUserCodeAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getAlertUserCodeAPIResult = .onSuccess(response: success)
                    
                    debugPrint("alerts success: \(success)")

                    self?.alertsData = success
                    
                case .failure(let failure):
                        self?.getAlertUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("alerts failure: \(failure)")
                }
            }
        }
    }
}

// MARK: SignalR
extension NotificationsViewModel {
    
}

// MARK: Function
extension NotificationsViewModel {
    
}
