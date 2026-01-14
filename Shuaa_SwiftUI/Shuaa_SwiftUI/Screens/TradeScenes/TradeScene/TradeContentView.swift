//
//  TradeContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 14/01/2026.
//

import Foundation
import SwiftUI

struct TradeContentView: View {
    
    @State var isSymbolDetailsExpanded: Bool = false
    @State var isAccountDetailsExpanded: Bool = false
    @State var selectedOrderType: OrderType = .buy
    
    
    var body: some View {
        VStack {
            SharedHeaderView()
            
            titleView
            
            sectionsView
            
            symbolDetailsView
            
            ScrollView(showsIndicators: false){
                accountDetailsView
                
                tradeDetailsView
            }

            bottomView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .trade)
        }
        .background(Color.colorBackground)
    }
    
    private var titleView: some View {
        Text("new_order".localized)
            .font(.apply(.bold, size: 16))
            .foregroundStyle(Color.colorTextPrimary)
            .padding(.top, 16)
    }
    
    private var sectionsView: some View {
        HStack {
            sectionView(title: "symbol".localized, value: "select_symbol".localized, isBottomSheet: true)
            sectionView(title: "account".localized, value: "select_account".localized, isBottomSheet: true)
        }
        .padding(.horizontal, 12)
    }
    
    private func sectionView(title:String, value: String, isBottomSheet: Bool = false, action: (() -> Void)? = nil) -> some View {
        VStack(alignment: .leading, spacing: 2) {
           Text(title)
               .font(.apply(.bold, size: 14))
               .foregroundStyle(Color.white)
               .padding(.horizontal, 8)
               .padding(.vertical, 6)
            
            if isBottomSheet {
                Button {
                    action?()
                } label: {
                    HStack {
                        Text(value)
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.white)

                        Spacer()
                        
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(Color.colorSymbol)
                    }
                    .padding(.horizontal, 12)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 18)
                .padding(.vertical, 6)
                .background(Color.colorBackgroundTertiary)
                .cornerRadius(16)

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
    
    private func sectionView2(title:String, value: String, isBottomSheet: Bool = false, action: (() -> Void)? = nil) -> some View {
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
                .cornerRadius(12)

            } else {
                Text(value)
                    .font(.apply(.regular, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 18)
                    .padding(.vertical, 6)
                    .background(Color.colorBackgroundSecondary)
                    .cornerRadius(12)
            }
       }
       .frame(maxWidth: .infinity)

    }

    private var symbolDetailsView: some View {
        Button {
            withAnimation {
                isSymbolDetailsExpanded.toggle()
            }
        } label: {
            VStack {
                HStack {
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 1)
                            .frame(maxHeight: 16)
                            .foregroundStyle(Color.colorTextPrimary)

                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: 150)
                            .foregroundStyle(Color.colorTextPrimary)
                    }

                    Spacer()
                    
                    Image("ic_upArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .rotationEffect(Angle(degrees: isSymbolDetailsExpanded ? 0 : 180))
                        .foregroundStyle(Color.colorSymbolSecondary)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                HStack {
                    
                    Spacer()

                    VStack(spacing: 4) {
                        Text("bid_volume".localized)
                            .font(.apply(.regular, size: 12))
                            
                        Text("0")
                            .font(.apply(.bold, size: 12))
                            
                    }
                    .foregroundStyle(Color.colorGreen)
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("bid".localized)
                            .font(.apply(.regular, size: 12))

                        Text("0")
                            .font(.apply(.bold, size: 12))

                    }
                    .foregroundStyle(Color.colorGreen)

                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("last_trade".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)
                        Text("0")
                            .font(.apply(.bold, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("offer".localized)
                            .font(.apply(.regular, size: 12))

                        Text("0")
                            .font(.apply(.bold, size: 12))

                    }
                    .foregroundStyle(Color.colorRed)

                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("offer_volume".localized)
                            .font(.apply(.regular, size: 12))

                        Text("0")
                            .font(.apply(.bold, size: 12))

                    }
                    .foregroundStyle(Color.colorRed)

                    Spacer()

                }
                .padding(.bottom, 4)

                if isSymbolDetailsExpanded {
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\("open".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Text("\("close".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                        }

                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\("top_price".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Text("\("low".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Text("\("high".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                        }

                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\("change".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Text("\("change_percent".localized) = \(AppUtility.shared.formatThousandSeparator(number: 0))%")
                                .font(.apply(.medium, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.vertical, 4)
                    
                    HStack(alignment: .top) {
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Text("turnover".localized)
                                .font(.apply(.bold, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                            
                            Text(AppUtility.shared.formatThousandSeparator(number: 0))
                                .font(.apply(.bold, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Text("volume".localized)
                                .font(.apply(.bold, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                            
                            Text(AppUtility.shared.formatThousandSeparator(number: 0))
                                .font(.apply(.bold, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Text("trades".localized)
                                .font(.apply(.bold, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                            
                            Text(AppUtility.shared.formatThousandSeparator(number: 0))
                                .font(.apply(.bold, size: 10))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        
                        Spacer()

                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack(alignment: .leading) {
                                Text("day_range".localized)
                                    .font(.apply(.medium, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .padding(.leading, 5)
                                    .opacity(0.5)

                                TextField("", text: .constant(""))
                                    .foregroundColor(.black) // text color
                            }

                            
                            Rectangle()
                                .fill(Color.colorRed)
                                .frame(height: 2)
                        }
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack(alignment: .leading) {
                                Text("turnover".localized)
                                    .font(.apply(.medium, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .padding(.leading, 5)
                                    .opacity(0.5)

                                TextField("", text: .constant(""))
                                    .foregroundColor(.black) // text color
                            }

                            
                            Rectangle()
                                .fill(Color.colorRed)
                                .frame(height: 2)
                        }
                        .padding()
                    }
                    .padding(.bottom, 8)
                }

            }
            .frame(maxWidth: .infinity)
            .background(Color.colorBackgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal, 12)
        }
        .buttonStyle(.plain)


    }
    
    private var accountDetailsView: some View {
        Button {
            withAnimation {
                isAccountDetailsExpanded.toggle()
            }
        } label: {
            VStack {
                HStack {

                    Spacer()
                    
                    Image("ic_upArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .rotationEffect(Angle(degrees: isAccountDetailsExpanded ? 0 : 180))
                        .foregroundStyle(Color.colorSymbolSecondary)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                VStack(spacing: 0) {
                    HStack {
                        HStack {
                            Text("buy_power".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Spacer()
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        .padding(.vertical, 4)

                        Rectangle()
                            .frame(width: 1)
                            .foregroundStyle(Color.colorTextPrimary)
                        
                        HStack {
                            Text("quantity".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Spacer()
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        .padding(.vertical, 4)
                        
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.colorTextPrimary)
                    
                    HStack {
                        HStack {
                            Text("cash".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Spacer()
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        .padding(.vertical, 4)

                        Rectangle()
                            .frame(width: 1)
                            .foregroundStyle(Color.colorTextPrimary)
                        
                        HStack {
                            Text("sell_order".localized)
                                .font(.apply(.regular, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            Spacer()
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                .font(.apply(.bold, size: 12))
                                .foregroundStyle(Color.colorTextPrimary)
                        }
                        .padding(.vertical, 4)
                        
                    }
                    
                    if isAccountDetailsExpanded {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.colorTextPrimary)

                        HStack {
                            HStack {
                                Text("facility_amount".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                                
                                Spacer()
                                
                                Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                    .font(.apply(.bold, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                            }
                            .padding(.vertical, 4)

                            Rectangle()
                                .frame(width: 1)
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            HStack {
                                Text("quantity".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                                
                                Spacer()
                                
                                Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                    .font(.apply(.bold, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                            }
                            .padding(.vertical, 4)
                            
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.colorTextPrimary)

                        HStack {
                            HStack {
                                Text("margin_amount".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                                
                                Spacer()
                                
                                Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                    .font(.apply(.bold, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                            }
                            .padding(.vertical, 4)

                            Rectangle()
                                .frame(width: 1)
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            HStack {
                                Text("trades".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                                
                                Spacer()
                                
                                Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                    .font(.apply(.bold, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                            }
                            .padding(.vertical, 4)
                            
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.colorTextPrimary)
                        
                        HStack {
                            HStack {
                                Text("min".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                                
                                Spacer()
                                
                                Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                    .font(.apply(.bold, size: 12))
                                    .foregroundStyle(Color.colorRed)
                            }
                            .padding(.vertical, 4)

                            Rectangle()
                                .frame(width: 1)
                                .foregroundStyle(Color.colorTextPrimary)
                            
                            HStack {
                                Text("max".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextPrimary)
                                
                                Spacer()
                                
                                Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                                    .font(.apply(.bold, size: 12))
                                    .foregroundStyle(Color.colorGreen)
                            }
                            .padding(.vertical, 4)
                        }
                        .padding(.bottom, 12)
                    }
                }
                .padding(.horizontal, 12)

            }
            .frame(maxWidth: .infinity)
            .background(Color.colorBackgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal, 12)
        }
        .buttonStyle(.plain)
    }
    
    private var tradeDetailsView: some View {
        VStack {
            HStack(spacing: 18) {
                Button {
                    withAnimation {
                        selectedOrderType = .buy
                    }
                } label: {
                    Text("buy".localized)
                        .font(.apply(.bold, size: 14))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(selectedOrderType == .buy ? Color.colorGreen : Color.colorBackgroundTertiary)
                        .cornerRadius(14)
                }
                
                Button {
                    withAnimation {
                        selectedOrderType = .sell
                    }
                } label: {
                    Text("sell".localized)
                        .font(.apply(.bold, size: 14))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(selectedOrderType == .sell ? Color.colorRed : Color.colorBackgroundTertiary)
                        .cornerRadius(14)
                }

            }
            .padding(.horizontal, 12)
            
            HStack {
                sectionView2(title: "quantity".localized, value: "0")
                sectionView2(title: "price".localized, value: "0")
            }
            
            HStack {
                sectionView2(title: "order_type".localized, value: "limit".localized, isBottomSheet: true)
                sectionView2(title: "validity_date".localized, value: "day".localized, isBottomSheet: true)
            }
            
            HStack {
                sectionView2(title: "", value: "calculate_quantity".localized)
                sectionView2(title: "", value: "advance".localized, isBottomSheet: true)
            }
            
            sectionView2(title: "order_value".localized, value: "0.0")
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
    
    private var bottomView: some View {
        VStack {
            Button {
                
            } label: {
                Text("trade")
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: 175)
                    .padding(.vertical, 8)
                    .background(Color.colorBackgroundTertiary)
                    .cornerRadius(16)
            }
        }
    }
}

#Preview {
    TradeContentView(
        
    )
}
