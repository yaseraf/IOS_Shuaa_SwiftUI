//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol HomeCoordinatorProtocol: AnyObject,Coordinator {
    func openHomeScene()
    func openShareDetailsScene()
    func openNewsDetailsScene(selectedNews: GetAllMarketNewsBySymbolUIModel)
    func openChartScene(selectedStock:GetCompaniesLookupsUIModel)
    func openFilterScene(delegate: WatchlistFilterDelegate, categoryFilter: [FilterCategoryModel], specificSharesFilter: SpecificShareTypes, sectorTypeFilter: SectorTypes)
    
    // -----------------
    
    func openManageScene()
    func openSettingScene()
}
