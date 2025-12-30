//
//  WatchlistDelegate.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/11/2025.
//

import Foundation

protocol WatchlistFilterDelegate {
    func onFilterChange(filter: [FilterCategoryModel], specificShareTypes: SpecificShareTypes, sectorTypes: SectorTypes)
}
