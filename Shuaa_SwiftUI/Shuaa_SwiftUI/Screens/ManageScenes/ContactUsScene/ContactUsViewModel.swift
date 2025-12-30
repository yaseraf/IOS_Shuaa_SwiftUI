//
//  ContactUsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 10/08/2025.
//

import Foundation

class ContactUsViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    
    init(coordinator: ManageCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
}
