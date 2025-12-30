//
//  ShareDetailsStockInfoContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import Foundation
import SwiftUI

struct ShareDetailsStockInfoContentView: View {
    
//    var selectedStock:Binding<HomePortfolioUIModel>
    var stockDetails:Binding<GetAllMarketWatchBySymbolUIModel?>

    enum ShareDetailsSections {
        case details
        case price
        case orders
        case trades
        case news
    }
    
    @State var selectedSection: ShareDetailsSections = .details
    
    var body: some View {
        VStack(spacing: 0) {
            Text("generic_market_information".localized)
                .font(.apply(.medium, size: 12))
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(Color.colorBGSecondary)
            
            VStack {
                HStack {
                    VStack(spacing: 0) {
                        Text("change".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\((Double(stockDetails.wrappedValue?.netChange ?? "") ?? 0) >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.netChange ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle((Double(stockDetails.wrappedValue?.netChange ?? "") ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("change_perc".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\((Double(stockDetails.wrappedValue?.netChangePerc ?? "") ?? 0) >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.netChangePerc ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 12))
                            .foregroundStyle((Double(stockDetails.wrappedValue?.netChangePerc ?? "") ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)

                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("trades".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.executed ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 12))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("volume".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.totalVolume ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 12))
                    }
                }
                .padding(.horizontal, 20)
                
                Divider()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                
                HStack {
                    VStack(spacing: 0) {
                        Text("company_market_value".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.companyFaceValue ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 12))
                    }
                    
                    Spacer()
                    
                    
                    VStack(spacing: 0) {
                        Text("value_qar".localized)
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextSecondary)
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.totalValue ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 12))
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 7)
            
            Text("stocks_market_information".localized)
                .font(.apply(.medium, size: 12))
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(Color.colorBGSecondary)
                .padding(.bottom, 7)
            
            HStack {
                VStack(spacing: 0) {
                    Text("previous_close".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\((Double(stockDetails.wrappedValue?.closePrice ?? "") ?? 0) >= 0 ? "+" : "-")\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.closePrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                        .foregroundStyle((Double(stockDetails.wrappedValue?.closePrice ?? "") ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("open_price".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\((Double(stockDetails.wrappedValue?.openPrice ?? "") ?? 0) >= 0 ? "+" : "-")\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.openPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                        .foregroundStyle((Double(stockDetails.wrappedValue?.openPrice ?? "") ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("low".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.lowPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("high".localized)
                        .font(.apply(.regular, size: 12))
                        .foregroundStyle(Color.colorTextSecondary)
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.highPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 7)
            
            VStack(spacing: 4) {
                Text("current_price")
                    .font(.apply(.regular, size: 12))
                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.lastTradePrice ?? "") ?? 0))")
                    .font(.apply(.semiBold, size: 12))
            }
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(Color.colorBGPositive)
            
            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text("offer_volume".localized)
                        .font(.apply(.regular, size: 12))
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.offerVolume ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .background(Color.colorOffer)
                
                VStack(spacing: 4) {
                    Text("offer_price".localized)
                        .font(.apply(.regular, size: 12))
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.offerPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .background(Color.colorOffer)
                
                VStack(spacing: 4) {
                    Text("bid_volume".localized)
                        .font(.apply(.regular, size: 12))
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.bidVolume ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .background(Color.colorBid)
                
                VStack(spacing: 4) {
                    Text("bid_price".localized)
                        .font(.apply(.regular, size: 12))
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(stockDetails.wrappedValue?.bidPrice ?? "") ?? 0))")
                        .font(.apply(.semiBold, size: 12))
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .background(Color.colorBid)
            }
            .frame(height: 52)
            .frame(maxWidth: .infinity)
        }

    }
}
