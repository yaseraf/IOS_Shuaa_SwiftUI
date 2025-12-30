//
//  NewsDetailsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI

struct NewsDetailsContentView: View {
    
    var newsData:Binding<GetAllMarketNewsBySymbolUIModel?>
    
    var onDismiss:()->Void

    
    var body: some View {
        VStack {
            headerView
            
            contentView
                .padding(.bottom, 10)
            
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.colorBorder)
                .frame(maxWidth: 46, maxHeight: 4)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            Text("QNB \("news".localized)")
                .font(.apply(.medium, size: 16))
                .padding(.bottom, 25)
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(AppUtility.shared.getHourOfTimeStamp(from: newsData.wrappedValue?.newsDate ?? ""))
                .font(.apply(.regular, size: 14))
                .foregroundStyle(Color.colorTextSecondary)
            
            ScrollView(.vertical, showsIndicators: false){
                Text("\(AppUtility.shared.getNewsContent(description: AppUtility.shared.isRTL ? newsData.wrappedValue?.newsDescA ?? "" : newsData.wrappedValue?.newsDescE ?? "", symbol: newsData.wrappedValue?.symbol ?? ""))")
                    .font(.apply(.regular, size: 14))
                
                Text("\(AppUtility.shared.getNewsContent(description: AppUtility.shared.isRTL ? newsData.wrappedValue?.newsDescA ?? "" : newsData.wrappedValue?.newsDescE ?? "", symbol: newsData.wrappedValue?.symbol ?? ""))")
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.colorTextSecondary)
            }

        }
        .padding(.horizontal, 20)
    }
    
    private var bottomButtonView: some View {
        Text("ok".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onDismiss()
            }
    }
}
