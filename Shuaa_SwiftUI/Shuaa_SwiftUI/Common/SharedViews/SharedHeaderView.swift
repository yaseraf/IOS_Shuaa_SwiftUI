//
//  SharedHeaderView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 04/01/2026.
//

import Foundation
import SwiftUI

struct SharedHeaderView: View {
    
    @State var symbolSearch = ""
    @State var isMenuOpen = false
    @State var withBackButton = false
    
    var onMenuTap: ()->Void

    var body: some View {
        headerView
    }
    
    private var headerView: some View {
        HStack {
            if withBackButton {
                Button {
                    SceneDelegate.getAppCoordinator()?.popViewController(animated: true)
                } label: {
                    Image(AppUtility.shared.isRTL ? "ic_rightArrow" : "ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.colorSymbol)
                }
                .buttonStyle(.plain)

            }
            
            Image("ic_connection")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.colorGreen)
            
            Image("ic_notification")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.colorSymbol)

            HStack(spacing: 0) {
                Image("ic_search")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.white)
                    .opacity(0.5)

                ZStack(alignment: .leading) {
                    if symbolSearch.isEmpty {
                        Text("symbol_search".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(Color.white)
                            .padding(.leading, 5)
                            .opacity(0.5)
                    }

                    TextField("", text: $symbolSearch)
                        .foregroundColor(.black) // text color
                }
            }
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorTextField))

            Button {
                withAnimation {
                    isMenuOpen.toggle()
                    onMenuTap()
                }
            } label: {
                Image("ic_menu")
                    .resizable()
                    .frame(width: 28, height: 22)
                    .foregroundStyle(Color.colorSymbol)
            }

            
        }
        .padding(.horizontal, 16)
    }

}

#Preview {
    SharedHeaderView(onMenuTap: {
        
    })
}
