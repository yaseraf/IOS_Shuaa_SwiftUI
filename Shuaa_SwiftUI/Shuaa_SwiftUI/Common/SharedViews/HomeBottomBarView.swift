//
//  HomeBottomBarView.swift
//  Shuaa
//
//  Created by FIT on 16/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct HomeBottomBarView: View {
   var refresh:Binding<Bool>?

    @State var selectedItem:HomeTabBarItem
    init(selectedItem: HomeTabBarItem,refresh:Binding<Bool>? = nil ) {
        self.selectedItem = selectedItem
        self.refresh = refresh
    }
    var body: some View {

        HStack{
            getItemView(item: .home)
            Spacer()
            getItemView(item: .orderList)
            Spacer()
            getItemView(item: .trade)
            Spacer()
            getItemView(item: .accounts)
            Spacer()
            getItemView(item: .portfolio)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(Color.colorBackgroundSecondary)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .overlay {
            Color.colorBackgroundSecondary
                .offset(y: 52)
        }
        .padding(.horizontal, 12)

    }

    func getItemView(item:HomeTabBarItem) -> some View {

            Button {
                actionTapBarITem(item: item)
            } label: {
                VStack(spacing: 6){
                    Image(selectedItem == item ? item == .home ? "ic_homeFill" : item == .portfolio ? "ic_portfolioFill" : item.iconName : item.iconName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 22)
                        .frame(height: 22)
                        .foregroundStyle(selectedItem == item ? Color.colorPrimary : Color.colorTextDisable)

                    Text(item.title)
                        .foregroundStyle(selectedItem == item ? Color.colorPrimary : Color.colorTextDisable)
                        .font(.apply(selectedItem == item  ? .bold : .regular,size: 12))
                }
            }
            .disabled(selectedItem == item)
    }

    func actionTapBarITem(item:HomeTabBarItem){
        switch item {
        case .home:
            SceneDelegate.getAppCoordinator()?.showHomeFlow()
            UserDefaultController().selectedBottomTab = .home
        case .orderList:
            SceneDelegate.getAppCoordinator()?.showOrderListFlow()
            UserDefaultController().selectedBottomTab = .orderList
        case .trade:
            SceneDelegate.getAppCoordinator()?.showTradeFlow()
            UserDefaultController().selectedBottomTab = .trade
        case .accounts:
            SceneDelegate.getAppCoordinator()?.showAccountsFlow()
            UserDefaultController().selectedBottomTab = .accounts
        case .portfolio:
            SceneDelegate.getAppCoordinator()?.showPortfolioFlow()
            UserDefaultController().selectedBottomTab = .portfolio
        }

    }
}

#Preview {
    HomeBottomBarView(
        selectedItem: .home
    )
}
