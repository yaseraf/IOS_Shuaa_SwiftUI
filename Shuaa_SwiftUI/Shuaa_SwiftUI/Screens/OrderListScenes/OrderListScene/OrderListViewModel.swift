//
//  OrderListViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation

class OrderListViewModel: ObservableObject {
    private let coordinator: OrderListCoordinatorProtocol
    
    @Published var userAccountsData: UserAccountsUIModel?
    
    init(coordinator: OrderListCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Mock Data
extension OrderListViewModel {
    func getUserAccountsData() {
        userAccountsData = .initMockData()
    }
}

// MARK: Routing
extension OrderListViewModel {
    
}

// MARK: API Calls
extension OrderListViewModel {
    
}

// MARK: Functions
extension OrderListViewModel {
    
}

// MARK: SingalRs
extension OrderListViewModel {
    
}

// MARK: Delegates
