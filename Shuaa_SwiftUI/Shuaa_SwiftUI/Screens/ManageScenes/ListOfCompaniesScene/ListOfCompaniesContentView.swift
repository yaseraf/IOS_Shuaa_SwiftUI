//
//  ListOfCompaniesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ListOfCompaniesContentView: View {
    
    var companiesLookupsData:Binding<[GetCompaniesLookupsUIModel]>
    var favoriteList:Binding<[GetMarketWatchByProfileIDUIModel]>
    
    @State private var  searchResult:String = ""
    
    var selectedShare:Binding<GetCompaniesLookupsUIModel?>
    
    var onDismiss:() -> Void
    var onHeartTap: (String) -> Void

    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            searchView
            
            ScrollView(.vertical, showsIndicators: false) {
                contentView
            }
            
            Spacer()
            
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("list_of_companies".localized)
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
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
        }
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
        .padding(16)
    }
    
    private var contentView: some View {
        LazyVStack {
            ForEach(Array((companiesLookupsData.wrappedValue).enumerated()), id: \.offset) { index, item in
                if searchResult.isEmpty {

                    Button {
                        selectedShare.wrappedValue = item
                        onHeartTap(item.symbol)
                    } label: {
                        HStack {
                            if UserDefaultController().isCompaniesLogoEnabled == true {
                                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol).jpg")) { phase in
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
                            HStack {
                                
                                Text("\(item.symbol)")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)
                                
                                Text(" - ")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextPrimary)
                                    .padding(.horizontal, 4)

                                Text("\(AppUtility.shared.isRTL ? item.shortNameA : item.shortNameE)")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextPrimary)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)

                            }
                            .padding(.horizontal, 4)

                            Spacer()
                            
                            Image(favoriteList.wrappedValue.contains(where: { $0.symbol == item.symbol }) == true ? "ic_heartFill" : "ic_heartEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                    }

                    
                    if (index != (companiesLookupsData.wrappedValue.count) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
                else if !searchResult.isEmpty && (item.symbol).lowercased().contains(searchResult.lowercased()) || (AppUtility.shared.isRTL ? (item.companyA ?? "").lowercased() : (item.companyE ?? "").lowercased()).contains(searchResult.lowercased()) {

                    Button {
                        selectedShare.wrappedValue = item
                        onHeartTap(item.symbol)
                    } label: {
                        HStack {
                            if UserDefaultController().isCompaniesLogoEnabled == true {
                                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol).jpg")) { phase in
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
                            HStack {

                                Text("\(item.symbol)")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)
                                
                                Text(" - ")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextPrimary)
                                    .padding(.horizontal, 4)

                                Text("\(AppUtility.shared.isRTL ? item.shortNameA : item.shortNameE)")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextPrimary)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)

                            }
                            .padding(.horizontal, 4)


                            
                            Spacer()
                            
                            Image(favoriteList.wrappedValue.contains(where: { $0.symbol == item.symbol }) == true ? "ic_heartFill" : "ic_heartEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity)
                    }

                    
                    if (index != (companiesLookupsData.wrappedValue.count) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

