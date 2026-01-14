//
//  OrderListContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 11/01/2026.
//

import Foundation
import SwiftUI

struct OrderListContentView: View {
    
    @State private var isSearching = false
    
    var labelsHeaderFontSize: CGFloat = 12
    var labelsHeaderFontColor = Color.white
    
    var userAccountsData:Binding<UserAccountsUIModel?>
    
    var onPortfolioTap:()->Void
    var onSideTap:()->Void
    var onOrderStatusTap:()->Void
    var onExchangeTap:()->Void
    var onSymbolTap:()->Void
    var onCancelTap:()->Void
    var onSearchOrderTap:()->Void
    
    var body: some View {
        VStack {
            SharedHeaderView()
            
            titleView
            
            accountsView
            
            if isSearching {
                searchView
            }
            
            labelsHeaderView
            
            ordersView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .orderList)
        }
        .background(Color.colorBackground)
    }
    
    private var titleView: some View {
        HStack {
  
            Spacer()
                        
            Button {
                withAnimation {
                    isSearching.toggle()
                }
            } label: {
                Image("ic_search")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.colorSymbol)
                    .frame(width: 18, height: 18)
                    .padding(6)
                    .background(Color.colorBackgroundTertiary)
                    .cornerRadius(8)
            }
        }
        .overlay {
            Text(isSearching ? "order_search".localized : "order_list".localized)
                .font(.apply(.bold, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
        }
        .padding(.horizontal, 12)
        .padding(.top, 8)
    }
    
    private var accountsView: some View {
        VStack {
            Text("\(userAccountsData.wrappedValue?.accountName ?? "")-\(userAccountsData.wrappedValue?.accountNumber ?? "")-\(userAccountsData.wrappedValue?.currency ?? "")")
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.colorBackgroundSecondary)
        .cornerRadius(8)
        .padding(.horizontal, 12)
    }
    
    private var searchView: some View {
        VStack {
            HStack {
                sectionView(title: "portfolio".localized, value: "all".localized, isBottomSheet: true, action: onPortfolioTap)
                sectionView(title: "side".localized, value: "all".localized, isBottomSheet: true, action: onSideTap)
            }
            HStack {
                sectionView(title: "from_date".localized, value: "11/01/2026".localized, action: onOrderStatusTap)
                sectionView(title: "to_date".localized, value: "11/01/2026".localized)
            }
            HStack {
                sectionView(title: "order_number".localized, value: "".localized)
                sectionView(title: "order_status".localized, value: "all".localized, isBottomSheet: true)
            }
            HStack {
                sectionView(title: "exchange".localized, value: "all".localized, isBottomSheet: true)
                sectionView(title: "symbol".localized, value: "select_symbol".localized, isBottomSheet: true)
            }
            
            HStack {
                Button {
                    onCancelTap()
                } label: {
                    Text("cancel".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 24)
                .padding(.vertical, 4)
                .background(Color.colorRed)
                .cornerRadius(8)
                .padding(.horizontal, 12)
                
                Button {
                    onSearchOrderTap()
                } label: {
                    Text("search_order".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 24)
                .padding(.vertical, 4)
                .background(Color.colorGreen)
                .cornerRadius(8)
                .padding(.horizontal, 12)


            }
        }
        .padding(.horizontal, 12)
    }
    
    private func sectionView(title:String, value: String, isBottomSheet: Bool = false, action: (() -> Void)? = nil) -> some View {
        VStack(alignment: .leading, spacing: 2) {
           Text(title)
               .font(.apply(.bold, size: 14))
               .foregroundStyle(Color.white)
               .padding(.horizontal, 8)
            
            if isBottomSheet {
                Button {
                    action?()
                } label: {
                    HStack {
                        Spacer()
                        
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(Color.colorSymbol)
                    }
                    .padding(.horizontal, 12)
                    .overlay {
                        Text(value)
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 18)
                .padding(.vertical, 6)
                .background(Color.colorBackgroundSecondary)
                .cornerRadius(8)

            } else {
                Text(value)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 18)
                    .padding(.vertical, 6)
                    .background(Color.colorBackgroundSecondary)
                    .cornerRadius(8)
            }
       }
       .frame(maxWidth: .infinity)

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
    
    private var ordersView: some View {
        VStack {
            Text("no_orders_yet".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    OrderListContentView(
        userAccountsData: .constant(.initMockData()),
        onPortfolioTap: {
            
        },
        onSideTap: {
            
        },
        onOrderStatusTap: {
            
        },
        onExchangeTap: {
            
        },
        onSymbolTap: {
            
        },
        onCancelTap: {
            
        },
        onSearchOrderTap: {
            
        }
    )
}
