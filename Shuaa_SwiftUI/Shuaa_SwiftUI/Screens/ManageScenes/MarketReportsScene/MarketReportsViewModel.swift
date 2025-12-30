//
//  MarketReportsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation
import UIKit

class MarketReportsViewModel: ObservableObject {
    private let coordinator: ManageCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol

    @Published var reports:[DailyReportsUIModel] = []

    @Published var reportsListModelAPIResult: APIResultType<[DailyReportsUIModel]>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}

// MARK: Routing
extension MarketReportsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension MarketReportsViewModel {
    func callReportsAPI() {
        
        let reportsType = "h"
               reportsListModelAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.Reports(reportsType: reportsType) {[weak self] result in
                self?.reportsListModelAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    self?.reports = success
                    self?.reportsListModelAPIResult = .onSuccess(response: success)
                case .failure(let failure):
                    
                    self?.reportsListModelAPIResult = .onFailure(error: failure)
                    
                }
            }
        }
    }
}

// MARK: Functions
extension MarketReportsViewModel {
    func download(index: Int){
        var urlString = AppEnvironmentController.currentNetworkConfiguration.basePath.replacingOccurrences(of: "MobileServices/", with: "") + self.reports[index].link.replacingOccurrences(of: " ", with: "%20")
        
        urlString = urlString.replacingOccurrences(of: "\\" , with: "/")
        print ("urlString \(urlString)")
        guard let url = URL(string: urlString) else { return }
        print (url)

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
