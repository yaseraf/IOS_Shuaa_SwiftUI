//
//  LogoutConfirmationViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/10/2025.
//

import Foundation
import WebKit

class LogoutConfirmationViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let usersLogOffUseCase: UsersLogOffUseCaseProtocol
    
    @Published var usersLogOffAPIResult:APIResultType<UsersLogOffUIModel>?

    init(coordinator: ManageCoordinatorProtocol, usersLogOffUseCase: UsersLogOffUseCaseProtocol) {
        self.coordinator = coordinator
        self.usersLogOffUseCase = usersLogOffUseCase
    }
}

// MARK: Routing
extension LogoutConfirmationViewModel {
    func dismiss() {
        coordinator.dismiss()
    }
}

// MARK: API Calls
extension LogoutConfirmationViewModel {
    func UsersLogOffAPI(success:Bool) {
        
        let requestModel = UsersLogOffRequestModel()
        usersLogOffAPIResult = .onLoading(show: true)
        
        Task.init {
            await usersLogOffUseCase.UsersLogOff(requestModel: requestModel) {[weak self] result in
                self?.usersLogOffAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.usersLogOffAPIResult = .onSuccess(response: success)
                    UserDefaultController().isLoggedIn = false
                    UserDefaultController().selectedUserAccount = nil
                    debugPrint("Logoff success")
                    
                    self?.disconnectSignalR()
                    
                    self?.signOut()
                    
                case .failure(let failure):
                        self?.usersLogOffAPIResult = .onFailure(error: failure)
                    debugPrint("Logoff fail")
                }
            }
        }
    }
}

// MARK: Functions
extension LogoutConfirmationViewModel {
    private func disconnectSignalR() {
        if Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.connection?.stop()
        }
    }
    
    func logout() {
        // Stop SignalR connection
        Connection_Hub.shared.connection?.stop()
        
        // Clear hub references
        Connection_Hub.shared.connection?.hubs.removeAll()
        
        // Remove from global connection list
        if let connection = Connection_Hub.shared.connection,
           let index = SwiftR.connections.firstIndex(where: { $0 === connection }) {
            SwiftR.connections.remove(at: index)
        }
        
        // Release WKWebView
        Connection_Hub.shared.connection?.wkWebView.removeFromSuperview()
        Connection_Hub.shared.connection?.wkWebView = nil
        
        // Optional: clear cookies & cache
        WKWebsiteDataStore.default().removeData(
            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
            modifiedSince: Date.distantPast
        ) {
            print("✅ SignalR completely disconnected and cleaned up")
        }
        
        // Reset singleton reference
        Connection_Hub.shared.connection = nil
        
        SceneDelegate.getAppCoordinator()?.logout()
    }
    
    func signOut() {
        UserDefaultController().isAutoLogin = false
        coordinator.dismiss(complete: {
            SceneDelegate.getAppCoordinator()?.logout()
        })
    }
}
