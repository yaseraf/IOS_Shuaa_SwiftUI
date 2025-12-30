//
//  NotificationsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI

struct NotificationsContentView: View {
    
    var alertsData:Binding<[GetAlertByUserCodeUIModel]?>
    
    var onBackTap:()->Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            if alertsData.wrappedValue?.isEmpty == false {
                ScrollView(.vertical, showsIndicators: false) {
                    contentView
                }
            } else {
                Spacer()
                
                Text("no_new_notifications".localized)
                    .font(.apply(.medium, size: 18))
                
            }
            

            Spacer()
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
            
            Text("notifications".localized)
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
            ForEach(Array((alertsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, element in
                HStack(alignment: .top) {
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image("ic_bell2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("notification".localized)
                            .font(.apply(.medium, size: 12))
                        Text("\(element.symbol ?? "") \(element.condition ?? "") \(element.conditionValue ?? "")")
                            .font(.apply(.regular, size: 12))
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Text("01:36 \("pm".localized)")
                        .font(.apply(.regular, size: 12))
                }
                .padding(.horizontal, 24)
                .frame(minHeight: 88)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                .padding(.horizontal, 20)
            }

        }
    }

}
