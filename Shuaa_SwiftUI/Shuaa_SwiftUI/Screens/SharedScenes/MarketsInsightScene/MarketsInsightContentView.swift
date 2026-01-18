//
//  MarketsInsightContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI

struct MarketsInsightContentView:View {
        
    var marketsInsightData:Binding<MarketsInsightUIModel?>
    
    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(
                    pinnedViews: [.sectionHeaders]
                ) {
                    sectionView(
                        title: "morning_reports".localized,
                        marketsInsightType: .morningReports
                    )
                    sectionView(
                        title: "market_wrap".localized,
                        marketsInsightType: .marketWrap
                    )
                    sectionView(
                        title: "weekly_dashboard".localized,
                        marketsInsightType: .weeklyDashboard
                    )
                }
            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: UserDefaultController().selectedBottomTab ?? .home)
        }
        .background(Color.colorBackground)
    }
        
    private func sectionView(title: String, marketsInsightType: MarketsInsightDataType) -> some View {
        Section(
            header: sectionHeader(title: title)
        ) {
            VStack {
                ForEach(Array((items(type: marketsInsightType)).enumerated()), id: \.offset) { index, item in
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(item.date ?? "")")
                            .font(.apply(.regular, size: 16))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)

                        if index != (marketsInsightData.wrappedValue?.morningReports?.count ?? 0) - 1 {
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .background(Color.colorBackgroundSecondary)
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
    
    private func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.apply(.regular, size: 14))
            .foregroundStyle(Color.colorWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(Color.colorBackgroundTertiary)
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .background(Color.colorBackgroundTertiary)
            .cornerRadius(8)
            .padding(.horizontal, 16)

    }

    private func items(type: MarketsInsightDataType) -> [MarketsInsightDataItem] {
        switch type {
        case .morningReports:
            return marketsInsightData.wrappedValue?.morningReports ?? []
        case .marketWrap:
            return marketsInsightData.wrappedValue?.marketWrap ?? []
        case .weeklyDashboard:
            return marketsInsightData.wrappedValue?.weeklyDashboard ?? []
        }
    }

    
}

#Preview {
    MarketsInsightContentView(
        marketsInsightData: .constant(.initMockData())
    )
}
