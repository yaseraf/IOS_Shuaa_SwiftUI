//
//  TransactionDetailsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 07/08/2025.
//

import Foundation
import SwiftUI

struct TransactionHistoryContentView: View {
    
    enum HomeFilter {
        case all
        case transfers
        case cashOut
        case cashIn
    }

    
    var transactionHistory:Binding<[GetB2bRequestUIModel]?>
    var userData:Binding<GetUserAccountsUIModel?>
    @State var selectedFilter: HomeFilter = .all

    var onBackTap:() -> Void
    var onPortfolioTap: () -> Void
    var onDetailsTap:(GetB2bRequestUIModel) -> Void

    var body: some View {
        VStack {
            headerView
            
            accountView
            
            filtersView
            
            detailsView
            
            Spacer()
            
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
            
            Text("history".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
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

    private var filtersView: some View {
        VStack(alignment: .center) {
            HStack {
                HStack {
                    Text("all".localized)
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(selectedFilter == .all ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .all ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .all
                }

                HStack {
                    Text("transfers".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedFilter == .transfers ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .transfers ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .transfers
                }

                HStack {
                    Text("cash_out".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedFilter == .cashOut ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .cashOut ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .cashOut
                }

                HStack {
                    Text("cash_in".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(selectedFilter == .cashIn ? Color.white : Color.colorTextSecondary)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 4)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(selectedFilter == .cashIn ? Color.colorPrimary : Color.clear)
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
                .onTapGesture {
                    selectedFilter = .cashIn
                }
            }
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 32)
    }
    
    func formatASPDate(_ aspString: String) -> String {
        // Remove "/Date(" and ")/"
        let cleaned = aspString
            .replacingOccurrences(of: "/Date(", with: "")
            .replacingOccurrences(of: ")/", with: "")
        
        // Extract only the milliseconds part (before + or -)
        let parts = cleaned.split(separator: "+")
        let millisecondsString = parts[0].split(separator: "-")[0]  // Handles both +0300 or -0300
        
        guard let milliseconds = Double(millisecondsString) else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: milliseconds / 1000)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }


    private var detailsView: some View {
        ScrollView {
            VStack {
                ForEach(Array((transactionHistory.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                    if item.REQ_TYPE == 2 || item.REQ_TYPE == 3 { // Cash out
                        if selectedFilter == .all || selectedFilter == .cashOut {
                            HStack {
                                Image(AppUtility.shared.isDarkTheme ? "ic_cashOutDark" : "ic_cashOutLight")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)

                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("cash_out".localized)
                                        .font(.apply(.semiBold, size: 14))

                                    Button {
                                        onDetailsTap(item)
                                    } label: {
                                        HStack(alignment: .center, spacing: 0) {
                                            Text("Details")
                                                .font(.apply(.regular, size: 12))
                                                .foregroundStyle(Color.colorPrimary)

                                            Image("ic_rightArrow")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 15, height: 15)

                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 0) {
                                    Text("\(item.TRANSFER_AMOUNT ?? "") \("QAR")")
                                        .font(.apply(.medium, size: 12))

                                    Text(formatASPDate(item.REQ_DATE ?? ""))
                                        .font(.apply(.regular, size: 12))
                                        .foregroundStyle(Color.colorTextSecondary)

                                }
                                
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                        }
                    } else if item.REQ_TYPE == 22 || item.REQ_TYPE == 23 { // Shares Transfer
                        if selectedFilter == .all || selectedFilter == .transfers {
                            HStack {
                                Image(AppUtility.shared.isDarkTheme ? "ic_sharesTransferDark" : "ic_sharesTransferLight")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)

                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("shares_transfer".localized)
                                        .font(.apply(.semiBold, size: 14))

                                    Button {
                                        onDetailsTap(item)
                                    } label: {
                                        HStack(alignment: .center, spacing: 0) {
                                            Text("Details")
                                                .font(.apply(.regular, size: 12))
                                                .foregroundStyle(Color.colorPrimary)

                                            Image("ic_rightArrow")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 15, height: 15)

                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 0) {
                                    Text("\(item.TRANSFER_AMOUNT ?? "") \("QAR")")
                                        .font(.apply(.medium, size: 12))

                                    Text(formatASPDate(item.REQ_DATE ?? ""))
                                        .font(.apply(.regular, size: 12))
                                        .foregroundStyle(Color.colorTextSecondary)

                                }
                                
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))

                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
    
}
