//
//  WatchlistContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 08/01/2026.
//

import Foundation
import SwiftUI

struct WatchlistContentView: View {
    
    var marketsData:Binding<[MarketsUIModel]?>

    var labelsHeaderFontSize: CGFloat = 14
    var labelsHeaderFontColor = Color.white

    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)

            headerView
            
            labelsHeaderView
            
            contentView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
        }
        .background(Color.colorBackground)
    }
    
    private var headerView: some View {
        HStack {
            Text("watchlist".localized)
                .font(.apply(.bold, size: 20))
                .foregroundStyle(labelsHeaderFontColor)

            Text("|")
                .font(.apply(.regular, size: 16))
                .foregroundStyle(labelsHeaderFontColor)

            
            Text("select_watchlist".localized)
                .font(.apply(.bold, size: 12))
                .foregroundStyle(labelsHeaderFontColor)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.colorBackgroundSecondary)
                .cornerRadius(8)
            
            Spacer()
            
            Image("ic_complex")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.colorSymbol)
                .frame(width: 28, height: 28)
            
            Image("ic_watchlistSort")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.colorSymbol)
                .frame(width: 28, height: 28)

            Image("ic_watchlistEdit")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.colorSymbol)
                .frame(width: 28, height: 28)

            Image("ic_watchlistAdd")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.colorSymbol)
                .frame(width: 28, height: 28)

        }
        .padding(.horizontal, 16)
    }
    
    private var labelsHeaderView: some View {
        VStack(spacing: 4) {
            HStack {
                Text("symbol".localized)
                    .font(.apply(.medium, size: labelsHeaderFontSize))
                    .foregroundStyle(labelsHeaderFontColor)
                
                Spacer()
                
                Text("bid".localized)
                    .font(.apply(.medium, size: labelsHeaderFontSize))
                    .foregroundStyle(labelsHeaderFontColor)

                Spacer()
                
                Text("last".localized)
                    .font(.apply(.medium, size: labelsHeaderFontSize))
                    .foregroundStyle(labelsHeaderFontColor)

                Spacer()

                Text("offer".localized)
                    .font(.apply(.medium, size: labelsHeaderFontSize))
                    .foregroundStyle(labelsHeaderFontColor)

                Spacer()

                Text("\("change".localized) | \("change_percent".localized)")
                    .font(.apply(.medium, size: labelsHeaderFontSize))
                    .foregroundStyle(labelsHeaderFontColor)
                
//                Spacer()
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 6)
        .background(Color.colorBackgroundTertiary)
        .cornerRadius(8)
        .padding(.horizontal, 12)
    }

    
    private var contentView: some View {
        VStack {
            Text("no_symbols_in_this_profile_for_now".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WatchlistContentView(
        marketsData: .constant([
            .initMockData()
        ])
    )
}
