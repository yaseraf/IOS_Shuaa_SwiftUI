//
//  AppRatingViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 10/08/2025.
//

import Foundation
class AppRatingViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    
    init(coordinator: ManageCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func onSendTap() {
        coordinator.popViewController()
    }
}
