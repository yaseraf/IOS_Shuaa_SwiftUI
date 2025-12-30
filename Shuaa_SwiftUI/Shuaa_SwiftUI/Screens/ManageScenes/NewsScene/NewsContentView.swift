//
//  NewsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI

struct NewsContentView: View {
    
    var newsData:Binding<[GetAllMarketNewsBySymbolUIModel]?>
    
    var onNewsDetailsTap: ((GetAllMarketNewsBySymbolUIModel) -> Void)
    var onBackTap:() -> Void
    
    var body: some View {
        VStack {
            headerView
            
            ScrollView(.vertical, showsIndicators: false) {
                Text(AppUtility.shared.isRTL ? "ديسمبر 2024" : "December 2024")
                    .font(.apply(.medium, size: 12))
                    .frame(minHeight: 36)
                    .frame(maxWidth: .infinity)
                    .background(Color.colorBGSecondary)
                
                Spacer().frame(height: 15)
                
                contentView
                
                Spacer().frame(height: 15)
                
                Text(AppUtility.shared.isRTL ? "اكتوبر 2024" : "October 2024")
                    .font(.apply(.medium, size: 12))
                    .frame(minHeight: 36)
                    .frame(maxWidth: .infinity)
                    .background(Color.colorBGSecondary)
                
                contentView
                
                Spacer().frame(height: 15)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(AppUtility.shared.isRTL ? "ic_rightArrow" : "ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onBackTap()
                }
            
            Spacer()
            
            Text("news".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }

    
    private var contentView: some View {
        VStack(spacing: 10) {
            ForEach(Array((newsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0) {
                        Text("\(AppUtility.shared.getHourOfTimeStamp(from: item.newsDate ?? ""))")
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Text("details".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorPrimary)
                            
                            Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                        .onTapGesture {
                            onNewsDetailsTap(item)
                        }
                    }
                    Text("\(AppUtility.shared.getNewsContent(description: AppUtility.shared.isRTL ? item.newsDescA ?? "" : item.newsDescE ?? "", symbol: item.symbol ?? ""))")
                        .font(.apply(.regular, size: 12))
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                .padding(.horizontal, 20)
            }
        }
    }
}
