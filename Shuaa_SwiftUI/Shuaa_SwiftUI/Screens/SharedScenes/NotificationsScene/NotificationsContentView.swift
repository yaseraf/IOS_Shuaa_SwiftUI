//
//  NotificationsContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI

struct NotificationsContentView:View {
        
    @State var selectedAlertType: AlertType = .orders
    
    var labelsHeaderFontSize: CGFloat = 12
    var labelsHeaderFontColor = Color.white

    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            sectionsView
            
            if selectedAlertType == .orders {
                labelsHeaderView
            }
            
            contentView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: UserDefaultController().selectedBottomTab ?? .home)
        }
        .background(Color.colorBackground)
    }
    
    private var sectionsView: some View {
        HStack(spacing: 0) {
            Button {
                selectedAlertType = .orders
            } label: {
                VStack {
                    Text("orders".localized)
                        .font(.apply(.bold, size: 18))
                        .foregroundStyle(Color.white)

                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: selectedAlertType == .orders ? 3 : 1)
                        .foregroundStyle(selectedAlertType == .orders ? Color(hex: "13FF14") : Color.white)
                        .opacity(selectedAlertType == .orders ? 1 : 0.4)
                        .cornerRadius(12)
                }
            }

            Button {
                selectedAlertType = .announcement
            } label: {
                VStack {
                    Text("announcement".localized)
                        .font(.apply(.bold, size: 18))
                        .foregroundStyle(Color.white)

                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: selectedAlertType == .announcement ? 3 : 1)
                        .foregroundStyle(selectedAlertType == .announcement ? Color(hex: "13FF14") : Color.white)
                        .opacity(selectedAlertType == .announcement ? 1 : 0.4)
                        .cornerRadius(12)

                }
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .padding(.top, 18)
        .padding(.bottom, 4)
    }
        
    private var labelsHeaderView: some View {
        VStack(spacing: 4) {
            HStack {
                VStack(spacing: 2) {
                    Text("symbol".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("order_number".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("date".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("time".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("price".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("avg_price".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("action".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("exchange".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("status".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("order_qty".localized)
                        .font(.apply(.medium, size: labelsHeaderFontSize))
                        .foregroundStyle(labelsHeaderFontColor)
                    Text("filled_qty".localized)
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
            Text("no_data_right_now".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

#Preview {
    NotificationsContentView(
        
    )
}
