//
//  HomeBottomBarView.swift
//  QSC
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
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.colorBGThird)

    }

    func getItemView(item:HomeTabBarItem) -> some View {

            Button {
                actionTapBarITem(item: item)
            } label: {
                VStack(spacing: 6){
                    Color.colorPrimary
                        .frame(height: 2)
                        .opacity(selectedItem == item ? 1 : 0)

                    Image(item.iconName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24)
                        .frame(height: 24)
                        .foregroundStyle(selectedItem == item ? Color.colorPrimary : Color.colorFGQuaternary)

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
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().start()
        case .orderList:
            if UserDefaultController().isPreviewMode == true {
                SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
            } else {
                SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().start()
            }
        case .trade:
            if UserDefaultController().isPreviewMode == true {
                SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
            } else {
                SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()
            }
        case .accounts:
            if UserDefaultController().isPreviewMode == true {
                SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
            } else {
                SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getFavoriteCoordinator().start()
            }
        case .portfolio:
            if UserDefaultController().isPreviewMode == true {
                SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
            } else {
                SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getManageCoordinator().start()
            }
        }

    }
}

//#Preview {
//    HomeBottomBarView(selectedItem: .pricing)
//}
