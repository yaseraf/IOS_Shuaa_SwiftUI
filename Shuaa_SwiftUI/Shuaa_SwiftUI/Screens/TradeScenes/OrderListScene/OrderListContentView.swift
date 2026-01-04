//
//  OrderListContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 11/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct OrderListContentView: View {
    
    var userData:Binding<GetUserAccountsUIModel?>
    var orderListData:Binding<[OrderListUIModel]?>
    var filteredSymbol:Binding<String>
    var filteredOSSList:Binding<[GetLookupsUIModel]?>

    var onPortfolioTap:()->Void
    var onStockTap:(OrderListUIModel, TypeOfTrade)->Void
    var onBackTap:()->Void
    var onSearchTap:()->Void
    var onResetTap:()->Void
    var onBuyTap:(TypeOfTrade)->Void
    var onSellTap:(TypeOfTrade)->Void
    
    var body: some View {
        VStack {
            headerView
            
            accountView
            
            contentView
            
            Spacer()
            
            bottomButtonsView
            
//            HomeBottomBarView(selectedItem: .orders)
//                .frame(maxWidth: .infinity)
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
            
            Text("order_list".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            HStack {
                Circle()
                    .fill(Color.colorBGSecondary)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_searchHeader")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .onTapGesture {
                        onSearchTap()
                    }
                
                if filteredSymbol.wrappedValue.count > 0 {
                    Text("reset".localized)
                        .foregroundStyle(Color.colorNegativeSecondary)
                        .font(.apply(.semiBold, size: 14))
                        .onTapGesture {
                            onResetTap()
                        }
                }
            }
        }
        .padding(.horizontal, 24)
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
            
            Text("\(AppUtility.shared.isRTL ? userData.wrappedValue?.ClientNameA ?? "" : userData.wrappedValue?.ClientNameE ?? "") - \(userData.wrappedValue?.NIN ?? "")")
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
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBGHeader))
//        .padding(.horizontal, 20)
        .onTapGesture {
            onPortfolioTap()
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("shares".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Spacer()
                Text("price".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Spacer()
                Text("the_rest".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Spacer()
                Text("remaining".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Spacer()
                Text("status".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            .lineLimit(1)
            .frame(maxHeight: 27)
            .padding(.horizontal, 30)
            .padding(.vertical, 6)
            .minimumScaleFactor(0.5)
            
            Divider().frame(height: 2).background(Color.colorBorder)
            
            ScrollView(.vertical, showsIndicators: false) {
                orderListView
            }
            
            Divider().frame(height: 2).background(Color.colorBorder)
        }
    }
    
    func convertToHourMinute(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss" // your input format
        
        guard let date = formatter.date(from: dateString) else {
            return ""
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm" // your desired output
        outputFormatter.locale = Locale(identifier: "en_US")
        
        return outputFormatter.string(from: date)
    }

    
    private var orderListView: some View {
        ForEach(Array((orderListData.wrappedValue ?? []).enumerated()).reversed(), id: \.offset) { index, item in
            
            if filteredSymbol.wrappedValue.count > 0 && filteredSymbol.wrappedValue == item.Symbol ?? "" {
                Button {
                    onStockTap(item, item.SellBuyFlag?.lowercased() == "b" ? .buy : .sell)
                } label: {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            if UserDefaultController().isCompaniesLogoEnabled == true {
                                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.Symbol ?? "").jpg")) { phase in
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

//                            Image("ic_QNB")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 56, height: 26)
                            
                            HStack(spacing: 0) {
                                Text("\(AppUtility.shared.isRTL ? "\(item.CompanyShortNameA ?? "") - " : "\(item.CompanyShortNameE ?? "") - ")")
                                    .font(.apply(.semiBold, size: 14))
                                Text("\(item.Symbol ?? "")")
                                    .font(.apply(.bold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                            }
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .padding(.horizontal, 4)
                            
                            Spacer()
                            
                            HStack {
                                Text(item.SellBuyFlag?.lowercased() == "b" ? "buy".localized : "sell".localized)
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(item.SellBuyFlag?.lowercased() == "b" ? Color.colorPositiveSecondary : Color.colorNegativeSecondary)
                                
                                Text(convertToHourMinute(from: item.ModifyDate ?? ""))
                                    .font(.apply(.semiBold, size: 14))
                            }
                            .padding(.horizontal, 4)
                            .background(RoundedRectangle(cornerRadius: 4).fill(Color.colorBG))
                        }
                        .padding(.bottom, 8)
                        
                        HStack(spacing: 0) {
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.ExecQty ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                                .clipped()
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Price ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))

                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.ExecQty ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Remaining ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                            
                            Text(description(for: item.StatusCode ?? ""))
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(getForegroundColor(m: item))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 4)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                        }
                        .lineLimit(1)
                        .frame(maxHeight: 32)
                        .minimumScaleFactor(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.colorBorder, lineWidth: 1))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(item.SellBuyFlag?.lowercased() == "b" ? Color.colorBGPositive : Color.colorBGNegative)
                }
                .buttonStyle(.plain)

            } else if filteredSymbol.wrappedValue.count == 0 {
                Button {
                    onStockTap(item, item.SellBuyFlag?.lowercased() == "b" ? .buy : .sell)
                } label: {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            
                            if UserDefaultController().isCompaniesLogoEnabled == true {
                                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.Symbol ?? "").jpg")) { phase in
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

                            
//                            Image("ic_QNB")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 56, height: 26)
                            
                            HStack(spacing: 0) {
                                Text("\(AppUtility.shared.isRTL ? "\(item.CompanyShortNameA ?? "") - " : "\(item.CompanyShortNameE ?? "") - ")")
                                    .font(.apply(.semiBold, size: 14))
                                Text("\(item.Symbol ?? "")")
                                    .font(.apply(.bold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                            }
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .padding(.horizontal, 4)
                            
                            Spacer()
                            
                            HStack {
                                Text(item.SellBuyFlag?.lowercased() == "b" ? "buy".localized : "sell".localized)
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(item.SellBuyFlag?.lowercased() == "b" ? Color.colorPositiveSecondary : Color.colorNegativeSecondary)
                                
                                Text(convertToHourMinute(from: item.ModifyDate ?? ""))
                                    .font(.apply(.semiBold, size: 14))
                            }
                            .padding(.horizontal, 4)
                            .background(RoundedRectangle(cornerRadius: 4).fill(Color.colorBG))
                        }
                        .padding(.bottom, 8)
                        
                        HStack(spacing: 0) {
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.ExecQty ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                                .clipped()
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Price ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))

                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.ExecQty ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Remaining ?? "") ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                            
                            Text(description(for: item.StatusCode ?? ""))
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(getForegroundColor(m: item))
                                .frame(maxHeight: 32)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 4)
                                .background(Color.colorBG.border(Color.colorBorder, width: 1))
                        }
                        .lineLimit(1)
                        .frame(maxHeight: 32)
                        .minimumScaleFactor(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.colorBorder, lineWidth: 1))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(item.SellBuyFlag?.lowercased() == "b" ? Color.colorBGPositive : Color.colorBGNegative)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var bottomButtonsView: some View {
        HStack {
            Text("buy".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.colorBuy))
                .onTapGesture {
                    onBuyTap(.buy)
                }
            
            Spacer()
            
            Text("sell".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.colorSell))
                .onTapGesture {
                    onSellTap(.sell)
                }
        }
        .padding(.horizontal, 24)
    }
    
    func description(for statusCode: String?) -> String {
        guard let code = statusCode else { return "" }
        return AppUtility.shared.isRTL ? filteredOSSList.wrappedValue?.first(where: { $0.id == code })?.descA ?? "" : filteredOSSList.wrappedValue?.first(where: { $0.id == code })?.descE ?? ""
    }
    
}



func getStatusDescE(m: OrderListUIModel) -> String {
    switch m.StatusCode?.lowercased() {
    case StatusType.s.symbol.lowercased():
        return StatusType.s.text
    case StatusType.p.symbol.lowercased():
        return StatusType.p.text
    case StatusType.w.symbol.lowercased():
        return StatusType.w.text
    case StatusType.r.symbol.lowercased():
        return StatusType.r.text
    case StatusType.c.symbol.lowercased():
        return StatusType.c.text
    case StatusType.a.symbol.lowercased():
        return StatusType.a.text
    case StatusType.e.symbol.lowercased():
        return StatusType.e.text
    case StatusType.t.symbol.lowercased():
        return StatusType.t.text
    default: return "null"
    }
}

func getBackgroundColor(m: OrderListUIModel) -> Color {
    switch m.StatusCode?.lowercased() {
    case StatusType.s.symbol.lowercased():
        return StatusType.s.backgroundColor
    case StatusType.p.symbol.lowercased():
        return StatusType.p.backgroundColor
    case StatusType.w.symbol.lowercased():
        return StatusType.w.backgroundColor
    case StatusType.r.symbol.lowercased():
        return StatusType.r.backgroundColor
    case StatusType.c.symbol.lowercased():
        return StatusType.c.backgroundColor
    case StatusType.a.symbol.lowercased():
        return StatusType.a.backgroundColor
    case StatusType.e.symbol.lowercased():
        return StatusType.e.backgroundColor
    case StatusType.t.symbol.lowercased():
        return StatusType.t.backgroundColor
    default: return Color.orange
    }
}

func getForegroundColor(m: OrderListUIModel) -> Color {
    switch m.StatusCode?.lowercased() {
    case StatusType.s.symbol.lowercased():
        return StatusType.s.foregroundColor
    case StatusType.p.symbol.lowercased():
        return StatusType.p.foregroundColor
    case StatusType.w.symbol.lowercased():
        return StatusType.w.foregroundColor
    case StatusType.r.symbol.lowercased():
        return StatusType.r.foregroundColor
    case StatusType.c.symbol.lowercased():
        return StatusType.c.foregroundColor
    case StatusType.a.symbol.lowercased():
        return StatusType.a.foregroundColor
    case StatusType.e.symbol.lowercased():
        return StatusType.e.foregroundColor
    case StatusType.t.symbol.lowercased():
        return StatusType.t.foregroundColor
    default: return Color.orange
    }
}

enum  StatusType{
    case s // fulfilled, green
    case p // partial fulfilled ,green
    case w // waiting, yellow
    case r // rejected, red
    case c // canceled, red
    case a // active, green
    case e // expired, red
    case t // sent, green
    
    var symbol: String {
        switch self {
        case .s: "s"
        case .p: "p"
        case .w: "w"
        case .r: "r"
        case .c: "c"
        case .a: "a"
        case .e: "e"
        case .t: "t"
        }
    }


    var text:String {
        switch self {
        case .s:
            "fully_filled".localized
        case .p:
            "partially_fulfilled".localized
        case .w:
            "waiting".localized
        case .r:
            "rejected".localized
        case .c:
            "cancelled".localized
        case .a:
            "active".localized
        case .e:
            "expired".localized
        case .t:
            "sent".localized
        }
    }

    var foregroundColor:Color {
        switch self {
        case .s:
            Color.colorSuccess
        case .p:
            Color.colorSuccess
        case .w:
            Color.colorWarning600
        case .r:
            Color.colorError
        case .c:
            Color.colorError
        case .a:
            Color.colorSuccess
        case .e:
            Color.colorError
        case .t:
            Color.colorSuccess
        }
    }

    var backgroundColor:Color {
        switch self {
        case .s:
            Color.colorSuccess50
        case .p:
            Color.colorSuccess50
        case .w:
            Color.colorWarning50
        case .r:
            Color.colorError50
        case .c:
            Color.colorError50
        case .a:
            Color.colorSuccess50
        case .e:
            Color.colorError50
        case .t:
            Color.colorSuccess50
        }
    }
}
