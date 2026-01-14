//
//  SplashViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import JavaScriptCore

class SplashViewModel: ObservableObject {
    private let coordinator: AppCoordinatorProtocol


    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }

}

// MARK: Mock Data
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

// MARK: API Calls
extension SplashViewModel {
    
}

// MARK: Functions
extension SplashViewModel {
    
}

// MARK: SingalRs
extension SplashViewModel {
    
}

// MARK: Delegates



