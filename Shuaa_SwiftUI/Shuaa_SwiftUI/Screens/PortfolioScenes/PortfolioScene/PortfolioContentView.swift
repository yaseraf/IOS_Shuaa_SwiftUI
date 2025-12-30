//
//  PortfolioContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct PortfolioContentView: View {
    
    var userData:Binding<GetUserAccountsUIModel?>
    var portfolioData:Binding<GetPortfolioUIModel?>
    
    var onPortfolioTap:() -> Void
    var onSellTap:(String) -> Void
    var onStockTap:(String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            accountView
            
            accountDetails
            
            titlesView
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false){
                contentView
            }
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .portfolio)
        }
    }
    
    private var headerView: some View {
        Text("portfolio".localized)
            .font(.apply(.medium, size: 16))
        
    }
    
    private var accountView: some View {
        HStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.colorBG)
                .overlay {
                    Image("ic_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            
            Text("\(userData.wrappedValue?.NIN ?? "") - \(AppUtility.shared.isRTL ? userData.wrappedValue?.ClientNameA ?? "" : userData.wrappedValue?.ClientNameE ?? "")")
                .font(.apply(.medium, size: 14))
                .padding(.horizontal, 8)
                .minimumScaleFactor(0.5)
                .lineLimit(1)

            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 24, height: 24)
                Circle()
                    .stroke(lineWidth: 1).fill(Color.colorBorder)
                    .frame(width: 24, height: 24)
                    .overlay {
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                    }
            }
                
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 52)
        .frame(maxWidth: .infinity)
        .background(Color.colorBGHeader)
        .onTapGesture {
            onPortfolioTap()
        }
    }
    
    private var accountDetails: some View {
        HStack {
            Spacer()
            VStack {
                VStack(spacing: -4) {
                    Text("purchasing_power".localized)
                        .font(.apply(.regular, size: 12))
//                    Text("\(AppUtility.shared.formatThousandSeparator(number: userData.wrappedValue?.purchasingPower ?? 0))")
                    Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.buyPower ?? "") ?? 0))
                        .font(.apply(.bold, size: 12))
                }
//                VStack(spacing: -4) {
//                    Text("commission".localized)
//                        .font(.apply(.regular, size: 12))
//                    Text("\(AppUtility.shared.formatThousandSeparator(number: userData.wrappedValue?.commission ?? 0))")
//                        .font(.apply(.bold, size: 12))
//                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            VStack {
                VStack(spacing: -4) {
                    Text("purchasing_value".localized)
                        .font(.apply(.regular, size: 12))
//                    Text("\(AppUtility.shared.formatThousandSeparator(number: userData.wrappedValue?.purchasingValue ?? 0))")
                    Text(AppUtility.shared.formatThousandSeparator(number: Double(portfolioData.wrappedValue?.accountSummaries.marketValue ?? "") ?? 0))
                        .font(.apply(.bold, size: 12))
                }
//                VStack(spacing: -4) {
//                    Text("total_value".localized)
//                        .font(.apply(.regular, size: 12))
//                    Text("\(AppUtility.shared.formatThousandSeparator(number: userData.wrappedValue?.totalValue ?? 0))")
//                        .font(.apply(.bold, size: 12))
//                }
            }
            .padding(.horizontal, 24)
            Spacer()

        }
        .frame(minHeight: 42)
        .frame(maxWidth: .infinity)
        .background(AppUtility.shared.isDarkTheme ? Color.colorBG : Color(hex: "#EBEDF6"))
    }
    
    private var titlesView: some View {
        HStack {
            VStack {
                Text("volume".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("available".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("market_value".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("avg_price".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("value".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("cost".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("net_pnl".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("achieved_pnl".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)

            }
        }
        .padding(.horizontal, 25)
        .frame(minHeight: 45)
        .frame(maxWidth: .infinity)
        .background(Color.colorBGThird)
    }
    
    private var contentView: some View {
        ForEach(Array((portfolioData.wrappedValue?.portfolioes ?? []).enumerated()), id: \.offset) { index, item in
            VStack(spacing:0) {
                HStack {
                    if UserDefaultController().isCompaniesLogoEnabled == true {
                        WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol ?? "").jpg")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 45, maxHeight: 45)
                                    .padding(.horizontal, 4)
                                    .foregroundStyle(.gray)
                            case .failure:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 45, maxHeight: 45)
                                    .padding(.horizontal, 4)
                                    .foregroundStyle(.gray)
                            case .empty:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 45, maxHeight: 45)
                                    .foregroundStyle(.gray)
                            @unknown default:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 45, maxHeight: 45)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    Text("\(AppUtility.shared.isRTL ? item.companyShortA ?? "" : item.companyShortE ?? "") -")
                        .font(.apply(.semiBold, size: 14))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)

                    Text("\(item.symbol ?? "")")
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Button {
                        onSellTap(item.symbol ?? "")
                    } label: {
                        Text("sell".localized)
                            .font(.apply(.semiBold, size: 14))
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 28)
                            .background(RoundedRectangle(cornerRadius: 4).fill(Color.colorSell))
                    }

                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)

                HStack(spacing:0) {
                    VStack {
                        
                        // Volume
                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.qty ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                        // Available
                        Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }
                    
                    VStack {
                        
                        // Market Value
                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.nValue ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        
                        // Avg. Price
                        Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }

                    VStack {
                        
                        // Value
                        Text("\(AppUtility.shared.formatThousandSeparator(number: 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        
                        // Cost
                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.ePrice ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }

                    VStack {
                        
                        // PnL
                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.pProf ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        
                        // Achieved PnL
                        Text("\(String(AppUtility.shared.formatThousandSeparator(number: 0)).replacingOccurrences(of: "-", with: ""))%")
                            .font(.apply(.semiBold, size: 14))
                            .foregroundStyle((0) >= 0 ? Color.colorPositive : Color.colorNegative)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }

                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                .padding(.bottom ,6)
                .padding(.horizontal, 15)

                
                Color.colorBGSecondary
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
            }
            .onTapGesture {
                onStockTap(item.symbol ?? "")
            }
        }
    }
}
