//
//  MarketDealsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct MarketDealsContentView: View {
    
    var marketDealsData:Binding<[GetMarketTimeSaleUIModel]?>

    var onBackTap:() -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            titlesView
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                contentView
            }
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
            
            Text("market_deals".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }

    private var titlesView: some View {
        HStack {
            VStack {
                Text("date".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("time".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("change".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("change_perc".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("quantity".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("value".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("price".localized)
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
        ForEach(Array((marketDealsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
            VStack(spacing:0) {
                HStack {
                    if UserDefaultController().isCompaniesLogoEnabled == true {
                        WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.Symbol ?? "").jpg")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 25, maxHeight: 25)
                                    .padding(.horizontal, 4)
                                    .foregroundStyle(.gray)
                            case .failure:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 25, maxHeight: 25)
                                    .padding(.horizontal, 4)
                                    .foregroundStyle(.gray)
                            case .empty:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 25, maxHeight: 25)
                                    .foregroundStyle(.gray)
                            @unknown default:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 25, maxHeight: 25)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }

                    Text("\(AppUtility.shared.isRTL ? item.SymbolA ?? "" : item.SymbolE ?? "") -")
                        .font(.apply(.semiBold, size: 14))
                    Text("\(item.Symbol ?? "")")
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
//                    Text("sell".localized)
//                        .font(.apply(.semiBold, size: 14))
//                        .foregroundStyle(.white)
//                        .frame(width: 60, height: 28)
//                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.colorOffer))
                        
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)

                HStack(spacing:0) {
                    VStack {
                        Text("\(formatToDateString(item.TradeTime ?? ""))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                        Text("\(formatToTimeString(item.TradeTime ?? ""))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }
                    
                    VStack {
                        Text("\(Double(item.NetChange ?? "") ?? 0 > 0 ? "+" : Double(item.NetChange ?? "") ?? 0 <= 0 ? "" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.NetChange ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .foregroundStyle(Double(item.NetChange ?? "") ?? 0 > 0 ? Color.colorPositiveSecondary : Double(item.NetChange ?? "") ?? 0 < 0 ? Color.colorNegativeSecondary : Double(item.NetChange ?? "") ?? 0 == 0 ? Color.colorZero : Color.colorPrimary)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
//                        
                        Text("\(Double(item.NetChgPerc ?? "") ?? 0 > 0 ? "+" : Double(item.NetChgPerc ?? "") ?? 0 <= 0 ? "" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.NetChgPerc ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .foregroundStyle(Double(item.NetChgPerc ?? "") ?? 0 > 0 ? Color.colorPositiveSecondary : Double(item.NetChgPerc ?? "") ?? 0 < 0 ? Color.colorNegativeSecondary : Double(item.NetChgPerc ?? "") ?? 0 == 0 ? Color.colorZero : Color.colorPrimary)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }

                    VStack {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Volume ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        
                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.Value ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    }
//
                    VStack {
                        Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Price ?? "") ?? 0))")
                            .font(.apply(.semiBold, size: 14))
                            .frame(maxWidth: .infinity)
                        
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
        }
    }
    
    // MARK: - Convert to "dd-MM-yyyy"
    func formatToDateString(_ input: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = formatter.date(from: input) else { return "" }

        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }

    // MARK: - Convert to "hh:mm a"
    func formatToTimeString(_ input: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = formatter.date(from: input) else { return "" }

        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }

}
