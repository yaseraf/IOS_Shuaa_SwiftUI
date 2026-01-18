//
//  MarketsInsightViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation

class MarketsInsightViewModel: ObservableObject {
    
    private let coordinator: AppCoordinatorProtocol
    
    @Published var marketsInsightData: MarketsInsightUIModel?
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
        
        self.marketsInsightData = .initMockData()
    }
}

// MARK: Mock Data
extension MarketsInsightViewModel {
    
}

// MARK: Routing
extension MarketsInsightViewModel {
    
}

// MARK: API Calls
extension MarketsInsightViewModel {
    
}

// MARK: Functions
extension MarketsInsightViewModel {
    
}

// MARK: SignalRs
extension MarketsInsightViewModel {
    
}

// MARK: Delegates


