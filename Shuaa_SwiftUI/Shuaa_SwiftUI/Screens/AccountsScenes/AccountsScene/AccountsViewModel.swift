//
//  AccountsViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation

class AccountsViewModel: ObservableObject {
    private let coordinator: AccountsCoordinatorProtocol
    
    @Published var userAccountsData: UserAccountsUIModel?
    
    init(coordinator: AccountsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Mock Data
extension AccountsViewModel {
    func getUserAccountsData() {
        userAccountsData = .initMockData()
    }
}

// MARK: Routing
extension AccountsViewModel {
    
}

// MARK: API Calls
extension AccountsViewModel {
    
}

// MARK: Functions
extension AccountsViewModel {
    
}

// MARK: SingalRs
extension AccountsViewModel {
    
}

// MARK: Delegates
