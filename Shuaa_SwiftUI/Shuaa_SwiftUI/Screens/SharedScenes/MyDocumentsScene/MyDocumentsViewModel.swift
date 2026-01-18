//
//  MyDocumentsViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation

class MyDocumentsViewModel: ObservableObject {
    
    private let coordinator: AppCoordinatorProtocol
    
    @Published var documentsData: [DocumentsUIModel]?
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
        
        self.documentsData = []
        self.documentsData = DocumentsUIModel.initMockData()
    }
}

// MARK: Mock Data
extension MyDocumentsViewModel {
    
}

// MARK: Routing
extension MyDocumentsViewModel {
    
}

// MARK: API Calls
extension MyDocumentsViewModel {
    
}

// MARK: Functions
extension MyDocumentsViewModel {
    
}

// MARK: SignalRs
extension MyDocumentsViewModel {
    
}

// MARK: Delegates


