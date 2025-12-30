//
//  SelectSharesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct SelectSharesContentView: View {
    
    var sharesDataTelecom:Binding<[SharesUIModel]?>
    var sharesDataInsurance:Binding<[SharesUIModel]?>
    var companiesLookupsData:Binding<[GetCompaniesLookupsUIModel]?>
    @State var searchResult:String = ""
    
    var selectedShare:Binding<GetCompaniesLookupsUIModel?>
    
    var onConfirm:(GetCompaniesLookupsUIModel?) -> Void
    var onDismiss:() -> Void
    
    var body: some View {
        VStack {
            headerView
            
            searchView
            
            ScrollView(.vertical, showsIndicators: false) {
                contentView
            }
            
            Spacer()
            
            bottomButtonView
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
                
                Text("select_shares".localized)
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
            ForEach(Array((companiesLookupsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                if searchResult.isEmpty {
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
                            
                            Text("\(item.symbol ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextSecondary)
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
                            
                            Text(" - ")
                                .font(.apply(.semiBold, size: 14))
                                .padding(.horizontal, 4)

                            Text("\(AppUtility.shared.isRTL ? item.shortNameA : item.shortNameE)")
                                .font(.apply(.semiBold, size: 14))
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)

                        }
                        .padding(.horizontal, 4)

                        Spacer()
                        
                        Image(selectedShare.wrappedValue?.symbol == item.symbol ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedShare.wrappedValue = item
                    }
                    
                    if (index != (companiesLookupsData.wrappedValue?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
                else if !searchResult.isEmpty && (item.symbol ?? "").lowercased().contains(searchResult.lowercased()) || (AppUtility.shared.isRTL ? (item.shortNameA ?? "").lowercased() : (item.shortNameE ?? "").lowercased()).contains(searchResult.lowercased()) {
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
                        HStack {

                            Text("\(item.symbol ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextSecondary)
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
                            
                            Text(" - ")
                                .font(.apply(.semiBold, size: 14))
                                .padding(.horizontal, 4)

                            Text("\(AppUtility.shared.isRTL ? item.shortNameA : item.shortNameE)")
                                .font(.apply(.semiBold, size: 14))
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)

                        }
                        .padding(.horizontal, 4)


                        
                        Spacer()
                        
                        Image(selectedShare.wrappedValue?.symbol == item.symbol ?? "" ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedShare.wrappedValue = item
                        }
                    
                    if (index != (companiesLookupsData.wrappedValue?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var bottomButtonView: some View {
        Text("confirm".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onConfirm(selectedShare.wrappedValue)
            }
    }
}
