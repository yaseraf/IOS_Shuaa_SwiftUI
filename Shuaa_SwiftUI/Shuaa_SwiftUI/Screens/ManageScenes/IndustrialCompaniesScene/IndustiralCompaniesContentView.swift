//
//  MarketSummaryContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct IndustrialCompaniesContentView: View {
    
    var industrialCompaniesData:Binding<[GetMarketWatchBySectorIDUIModel]?>
    @State var searchResult:String = ""
    
    var onBackTap:() -> Void
    var onCompanyTap:() -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            searchView
            
            ScrollView(.vertical, showsIndicators: false){
                contentView
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.colorBorder)
                .frame(maxWidth: 46, maxHeight: 4)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("industrial_companies".localized)
                    .font(.apply(.medium, size: 16))
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorder))
                    .onTapGesture {
                        onBackTap()
                    }
            }
            .padding(.horizontal, 24)
        }
        .padding(.top, 16)
    }

    private var searchView: some View {
        HStack {
            Image("ic_search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField("search".localized, text: $searchResult)
                .font(.apply(.regular, size: 14))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder))
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
    
    private var contentView: some View {
        VStack {
            ForEach(Array((industrialCompaniesData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                if searchResult.isEmpty && item.symbol?.isEmpty == false {
                    VStack(spacing: 4) {
                        HStack {
                            if UserDefaultController().isCompaniesLogoEnabled == true {
                                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol ?? "").jpg")) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    case .failure:
                                        Image("ic_selectStock")
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    case .empty:
                                        Image("ic_selectStock")
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    @unknown default:
                                        Image("ic_selectStock")
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            HStack {
                                Text("\(AppUtility.shared.isRTL ? item.symbolNameA ?? "" : item.symbolNameE ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                
                                Text(" - ")
                                    .font(.apply(.semiBold, size: 14))
                                    .padding(.horizontal, 4)

                                Text("\(item.symbol ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                            }
                            .padding(.horizontal, 4)

                            Spacer()
                        }
                        
                        HStack(spacing: 0) {
                            Text(item.offerVolume ?? "")
                                .font(.apply(.medium, size: 12))
                            Spacer()
                            Text(item.offerPrice ?? "")
                                .font(.apply(.medium, size: 12))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 4)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBid))
                            Spacer()
                            Text(item.lastTradePrice ?? "")
                                .font(.apply(.medium, size: 12))
                                .foregroundStyle(Color.colorPositiveSecondary)
                            Spacer()
                            Text(item.bidPrice ?? "")
                                .font(.apply(.medium, size: 12))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 4)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorOffer))
                            Spacer()
                            Text(item.bidVolume ?? "")
                                .font(.apply(.medium, size: 12))
                            Spacer()
                            Text("\(Double(item.netChangePerc ?? "") ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.netChangePerc ?? "") ?? 0))")
                                .font(.apply(.medium, size: 12))
                                .foregroundStyle(Double(item.netChangePerc ?? "") ?? 0 > 0 ? Color.colorPositiveSecondary : Double(item.netChangePerc ?? "") ?? 0 < 0 ? Color.colorNegativeSecondary : Color.colorZero)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        onCompanyTap()
                    }
                    
                } else if !searchResult.isEmpty && (item.symbol ?? "").lowercased().contains(searchResult.lowercased()) || (AppUtility.shared.isRTL ? (item.symbolNameA ?? "").lowercased() : (item.symbolNameE ?? "").lowercased()).contains(searchResult.lowercased()) {
                    VStack(spacing: 4) {
                        HStack {
                            if UserDefaultController().isCompaniesLogoEnabled == true {
                                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol ?? "").jpg")) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    case .failure:
                                        Image("ic_selectStock")
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    case .empty:
                                        Image("ic_selectStock")
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    @unknown default:
                                        Image("ic_selectStock")
                                            .padding(.horizontal, 4)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            HStack {
                                Text("\(AppUtility.shared.isRTL ? item.symbolNameA ?? "" : item.symbolNameE ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                
                                Text(" - ")
                                    .font(.apply(.semiBold, size: 14))
                                    .padding(.horizontal, 4)

                                Text("\(item.symbol ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                            }
                            .padding(.horizontal, 4)

                            Spacer()
                        }
                        
                        HStack(spacing: 0) {
                            Text(item.offerVolume ?? "")
                                .font(.apply(.medium, size: 12))
                            Spacer()
                            Text(item.offerPrice ?? "")
                                .font(.apply(.medium, size: 12))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 4)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBid))
                            Spacer()
                            Text(item.lastTradePrice ?? "")
                                .font(.apply(.medium, size: 12))
                                .foregroundStyle(Color.colorPositiveSecondary)
                            Spacer()
                            Text(item.bidPrice ?? "")
                                .font(.apply(.medium, size: 12))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 4)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorOffer))
                            Spacer()
                            Text(item.bidVolume ?? "")
                                .font(.apply(.medium, size: 12))
                            Spacer()
                            Text("\(Double(item.netChangePerc ?? "") ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.netChangePerc ?? "") ?? 0))")
                                .font(.apply(.medium, size: 12))
                                .foregroundStyle(Double(item.netChangePerc ?? "") ?? 0 > 0 ? Color.colorPositiveSecondary : Double(item.netChangePerc ?? "") ?? 0 < 0 ? Color.colorNegativeSecondary : Color.colorZero)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        onCompanyTap()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
