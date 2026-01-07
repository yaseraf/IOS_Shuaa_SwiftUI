//
//  SplashViewModel.swift
//  QSC_SwiftUI
//
//  Created by Tawfeeq Irshaidat on 21/07/2025.
//

import Foundation
import JavaScriptCore

class SplashViewModel: ObservableObject {
    private let coordinator: AppCoordinatorProtocol


    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }

}

// MARK: API Calls
extension SplashViewModel {
}

// MARK: Routing
extension SplashViewModel {
    
    func openLoginScene() {
        coordinator.startFlow(startWith: .login)
    }
    
    func openHomeScene() {
        coordinator.showHomeFlow()
    }
}
