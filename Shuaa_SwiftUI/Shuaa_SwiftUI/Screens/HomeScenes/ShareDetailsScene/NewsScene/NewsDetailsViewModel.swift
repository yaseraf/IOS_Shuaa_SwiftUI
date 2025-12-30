//
//  NewsDetailsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation

class NewsDetailsViewModel: ObservableObject {
    private var coordinator: HomeCoordinatorProtocol
    
    @Published var newsData: GetAllMarketNewsBySymbolUIModel?
    
    init(coordinator: HomeCoordinatorProtocol, newsData: GetAllMarketNewsBySymbolUIModel) {
        self.coordinator = coordinator
        self.newsData = newsData
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
}
