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

// Mock Data
extension OrderListViewModel {
    func getUserAccountsData() {
        userAccountsData = .initMockData()
    }
}
