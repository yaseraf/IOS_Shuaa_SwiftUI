//
//  FilterViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation

struct FilterCategoryModel {
    var name: String
    var id: Int
}

class FilterViewModel: ObservableObject {
    
    private var coordinator: HomeCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol
    private var delegate: WatchlistFilterDelegate?
    
    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?

    @Published var filterCategoryItems: [FilterCategoryModel] = []
    @Published var selectedSpecificShareType: SpecificShareTypes?
    @Published var selectedSectorType: SectorTypes?
    @Published var marketWatchData: [GetMarketWatchByProfileIDUIModel]?

    init(coordinator: HomeCoordinatorProtocol, useCase: HomeUseCaseProtocol, delegate: WatchlistFilterDelegate, categoryFilter: [FilterCategoryModel], specificSharesFilter: SpecificShareTypes, sectorFilter: SectorTypes) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.delegate = delegate
        self.filterCategoryItems = categoryFilter
        self.selectedSpecificShareType = specificSharesFilter
        self.selectedSectorType = sectorFilter
    }
    
    func onCloseTap() {
        coordinator.dismiss()
    }
    
    func onConfirmTap() {
        delegate?.onFilterChange(filter: filterCategoryItems, specificShareTypes: selectedSpecificShareType ?? .all, sectorTypes: selectedSectorType ?? .active)
        coordinator.dismiss()
    }
}

// MARK: API Calls
extension FilterViewModel {
    func callGetMarketWatchByProfileIDAPI() {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.marketWatchData?.removeAll()
                    self?.marketWatchData = success
                    
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
               
                }
            }
        }

    }

}
