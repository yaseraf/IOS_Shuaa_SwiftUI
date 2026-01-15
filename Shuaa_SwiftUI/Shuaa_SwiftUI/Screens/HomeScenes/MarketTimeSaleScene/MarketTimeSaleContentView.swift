//
//  MarketTimeSaleContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI

struct MarketTimeSaleContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>

    var labelsHeaderFontSize: CGFloat = 12
    var labelsHeaderFontColor = Color.white

    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            SharedMarketsView(marketsData: marketsData)
            
            labelsHeaderView
            
            contentView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
        }
    }
    
    private var labelsHeaderView: some View {
        VStack(spacing: 4) {
            HStack {
                VStack(spacing: 2) {
                    Text("symbol".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("price".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("volume".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("turnover".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("change".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("change_percent".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("time".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("date".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(Color.colorBackgroundTertiary)
        .cornerRadius(12)
        .padding(.horizontal, 12)
    }

    
    private var contentView: some View {
        VStack {
            Text("no_symbols_yet".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MarketTimeSaleContentView(
        marketsData: .constant([
            .initMockData()
        ])
    )
}
