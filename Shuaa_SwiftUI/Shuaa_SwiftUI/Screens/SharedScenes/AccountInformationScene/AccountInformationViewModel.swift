//
//  AccountInformationViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation

class AccountInformationViewModel: ObservableObject {
    
    private let coordinator: AppCoordinatorProtocol
    
    @Published var accountInformationData: AccountInformationUIModel?
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
        
        self.accountInformationData = .initMockData()
    }
}

// MARK: Mock Data
extension AccountInformationViewModel {
    
}

// MARK: Routing
extension AccountInformationViewModel {
    
}

// MARK: API Calls
extension AccountInformationViewModel {
    
}

// MARK: Functions
extension AccountInformationViewModel {
    
}

// MARK: SignalRs
extension AccountInformationViewModel {
    
}

// MARK: Delegates


