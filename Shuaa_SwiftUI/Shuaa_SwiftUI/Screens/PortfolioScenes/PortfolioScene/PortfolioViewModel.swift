//
//  PortfolioViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation

class PortfolioViewModel: ObservableObject {
    private let coordinator: PortfolioCoordinatorProtocol
    
    @Published var userAccountsData: UserAccountsUIModel?
    @Published var portfolioData: PortfolioUIModel?
    
    init(coordinator: PortfolioCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// Mock Data
extension PortfolioViewModel {
    func getUserAccountsData() {
        userAccountsData = .initMockData()
    }
    
    func getPortfolioData() {
        portfolioData = .initMockData()
    }
}
