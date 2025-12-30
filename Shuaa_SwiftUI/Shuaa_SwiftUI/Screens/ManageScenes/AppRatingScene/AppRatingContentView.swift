//
//  AppRatingContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 10/08/2025.
//

import Foundation
import SwiftUI

struct AppRatingContentView: View {
    
    let onImages = ["ic_oneStarOn", "ic_twoStarOn", "ic_threeStarOn", "ic_fourStarOn", "ic_fiveStarOn"]
    let offImages = ["ic_oneStarOff", "ic_twoStarOff", "ic_threeStarOff", "ic_fourStarOff", "ic_fiveStarOff"]
    
    @State var comment = ""

    @State var selectedRating:Int = 0
        
    var onBackTap:()->Void
    var onSendTap:()->Void
    
    var body: some View {
        VStack {
            headerView
            
            contentView
            
            Spacer()
            
            bottomButtonView
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
            
            Text("rate_experience".localized)
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
        VStack(spacing: 12) {
            Text("how_do_you_rate_the_in_app_trading_experience".localized)
                .font(.apply(.regular, size: 14))
            
            HStack {
                ForEach(0..<onImages.count, id: \.self) { index in
                    Image(selectedRating >= index + 1 ? onImages[index] : offImages[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .onTapGesture {
                            selectedRating = index + 1
                        }
                }
            }
            
            ZStack(alignment: .topLeading) {
                
                // Multiline editor
                TextEditor(text: $comment)
                    .font(.apply(.regular, size: 14))
                    .frame(maxHeight: 96)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .fill(Color.colorBorder)
                    )
                    .padding(.horizontal, 16)

                
                    // Placeholder text
                    if comment.isEmpty {
                        Text("add_comment".localized)
                            .font(.apply(.regular, size: 14))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 32)
                            .padding(.top, 12)
                    }
                    
                   
                }
                .padding(.bottom, 8)
        }
    }
    
    private var bottomButtonView: some View {
        Text("send_rate".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onSendTap()
            }
    }

}
