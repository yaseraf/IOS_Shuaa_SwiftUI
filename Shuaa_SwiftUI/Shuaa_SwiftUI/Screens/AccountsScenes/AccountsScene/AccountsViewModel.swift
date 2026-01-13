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

// Mock Data
extension AccountsViewModel {
    func getUserAccountsData() {
        userAccountsData = .initMockData()
    }
}
