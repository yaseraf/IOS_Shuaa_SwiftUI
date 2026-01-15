//
//  WatchlistViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

class WatchlistViewModel:ObservableObject {
    
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var marketsData: [MarketsUIModel]?

    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Mock Data
extension WatchlistViewModel {
    func getMarketsData() {
        marketsData = []
        marketsData?.append(.initMockData())
    }
}

// MARK: Routing
extension WatchlistViewModel {
    
}

// MARK: API Calls
extension WatchlistViewModel {
    
}

// MARK: Functions
extension WatchlistViewModel {
    
}

// MARK: SingalRs
extension WatchlistViewModel {
    
}

// MARK: Delegates
