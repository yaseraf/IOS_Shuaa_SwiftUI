//
//  MarketInsightModel.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 18/01/2026.
//

import Foundation

struct MarketsInsightUIModel {
    var morningReports: [MarketsInsightDataItem]?
    var marketWrap: [MarketsInsightDataItem]?
    var weeklyDashboard: [MarketsInsightDataItem]?
    
    static func initializer() -> Self {
        return MarketsInsightUIModel()
    }
    
    static func initMockData() -> Self {
        return MarketsInsightUIModel(
            morningReports: [
                MarketsInsightDataItem(
                    date: "Thu - 17 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Mon - 14 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Fri - 11 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Thu - 10 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Wed - 09 July 2025"
                )
            ],
            marketWrap: [
                MarketsInsightDataItem(
                    date: "Thu - 17 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Mon - 14 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Fri - 11 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Thu - 10 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Wed - 09 July 2025"
                )
            ],
            weeklyDashboard: [
                MarketsInsightDataItem(
                    date: "Thu - 17 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Mon - 14 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Fri - 11 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Thu - 10 July 2025"
                ),
                MarketsInsightDataItem(
                    date: "Wed - 09 July 2025"
                )
            ]
        )
    }
}

struct MarketsInsightDataItem {
    var date: String?
}
