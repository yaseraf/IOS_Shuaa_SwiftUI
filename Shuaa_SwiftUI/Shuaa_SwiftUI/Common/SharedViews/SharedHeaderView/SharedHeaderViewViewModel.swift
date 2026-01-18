//
//  SharedHeaderViewViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation

class SharedHeaderViewViewModel: ObservableObject {
    
    static let shared = SharedHeaderViewViewModel()
    
    var sideMenuDelegate: SideMenuDelegate?
    
    @Published var symbolSearch = ""
    
    init() {
        
    }
}

// MARK: Routing
extension SharedHeaderViewViewModel {
    func openAlertsScene() {
        SceneDelegate.getAppCoordinator()?.openAlertsScene()
    }
}
