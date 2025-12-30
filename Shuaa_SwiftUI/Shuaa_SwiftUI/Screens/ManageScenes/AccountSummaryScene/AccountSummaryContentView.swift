//
//  AccountSummaryContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation
import SwiftUI

struct AccountSummaryContentView: View {
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    var currentDate:Binding<Date>
    var selectedDateFrom:Binding<Date?>
    var selectedDateTo:Binding<Date?>
    var userData:Binding<GetUserAccountsUIModel?>
    var accountSummaryData:Binding<[AccountSummaryUIModel]?>
    var statementsData:Binding<[GetStatementOfAccountUIModel]?>
    var groupedStatementsData:Binding<[GetStatementOfAccountUIModel]?>
    
    enum AccountSummaryType {
        case accountReports
        case collected
        case statementUponRequest
    }
    
    @State var selectedAccountSummaryType:AccountSummaryType = .accountReports
    
    var onPortfolioTap:() -> Void
    var onCalendarTap:() -> Void
    var onBackTap:() -> Void
    var onAccountSummaryTypeSelect:(AccountSummaryType) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            headerView
            
            accountView
            
            selectionView
            
            titlesView
            
            Divider()

            contentView
            
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
            
            Text("account_summary".localized)
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
    
    private var selectionView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("select_date".localized)
                    .font(.apply(.semiBold, size: 14))
                
                Spacer()
                
                HStack(spacing: 8) {
                    Image("ic_calendar")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.colorTextPrimary)
                        .frame(width: 20, height: 20)
                    
                    Text("\(selectedDateFrom.wrappedValue?.toString(dateFormat: .ddMMyyyy) ?? "") - \(selectedDateTo.wrappedValue?.toString(dateFormat: .ddMMyyyy) ?? "")")
                        .font(.apply(.medium, size: 14))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onCalendarTap()
                }
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("select_the_type_of_account_summary".localized)
                    .font(.apply(.semiBold, size: 14))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8){
                            
//                        Button(action: {
//                            selectedAccountSummaryType = .accountReports
//                            onAccountSummaryTypeSelect(selectedAccountSummaryType)
//                        }, label: {
//                            HStack(spacing: 4) {
//                                Image("ic_accountReports")
//                                    .renderingMode(.template)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundStyle(selectedAccountSummaryType == .accountReports ? Color.colorPrimary : Color.colorTextPrimary)
//                                    .frame(width: 16, height: 16)
//                                
//                                Text("account_reports".localized)
//                                    .font(.apply(.regular, size: 14))
//                                    .foregroundStyle(selectedAccountSummaryType == .accountReports ? Color.colorPrimary : Color.colorTextPrimary)
//                            }
//                            .padding(.vertical, 6)
//                            .padding(.horizontal, 8)
//                            .background(
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 8).fill(selectedAccountSummaryType == .accountReports ? Color(hex: "#F7F8FB") : Color.clear)
//                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedAccountSummaryType == .accountReports ? Color.colorPrimary : Color.colorBorder)
//                                }
//                            )
//                        })
                       
                        Button(action: {
                            selectedAccountSummaryType = .collected
                            onAccountSummaryTypeSelect(selectedAccountSummaryType)
                        }, label: {
                            HStack(spacing: 4) {
                                Image("ic_collected")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(selectedAccountSummaryType == .collected ? Color.colorPrimary : Color.colorTextPrimary)
                                    .frame(width: 16, height: 16)
                                
                                Text("collected".localized)
                                    .font(.apply(.regular, size: 14))
                                    .foregroundStyle(selectedAccountSummaryType == .collected ? Color.colorPrimary : Color.colorTextPrimary)
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(selectedAccountSummaryType == .collected ? Color(hex: "#F7F8FB") : Color.clear)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedAccountSummaryType == .collected ? Color.colorPrimary : Color.colorBorder)
                                }
                            )
                        })
                        
                        Button(action: {
                            selectedAccountSummaryType = .statementUponRequest
                            onAccountSummaryTypeSelect(selectedAccountSummaryType)
                        }, label: {
                            HStack(spacing: 4) {
                                Image("ic_statementUponRequest")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(selectedAccountSummaryType == .statementUponRequest ? Color.colorPrimary : Color.colorTextPrimary)
                                    .frame(width: 16, height: 16)
                                
                                Text("statement_upon_request".localized)
                                    .font(.apply(.regular, size: 14))
                                    .foregroundStyle(selectedAccountSummaryType == .statementUponRequest ? Color.colorPrimary : Color.colorTextPrimary)
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(selectedAccountSummaryType == .statementUponRequest ? Color(hex: "#F7F8FB") : Color.clear)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedAccountSummaryType == .statementUponRequest ? Color.colorPrimary : Color.colorBorder)
                                }
                            )
                        })
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
    }
    
    private var titlesView: some View {
        HStack {
            VStack {
                Text("date".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("shares".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("sell_buy".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("volume".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("avg_price".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("value".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
            }
            Spacer()
            VStack {
                Text("balance".localized)
                    .font(.apply(.medium, size: 12))
                    .foregroundStyle(Color.colorTextSecondary)
                Text("requests".localized)
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
        ScrollView(.vertical, showsIndicators: false) {
            Text("\("opening_balance".localized): \(statementsData.wrappedValue?.first?.balance ?? 0)")
                .font(.apply(.semiBold, size: 12))
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .padding(.horizontal, 15)
            
            ForEach(Array(((selectedAccountSummaryType == .accountReports ? statementsData.wrappedValue : selectedAccountSummaryType == .collected ? groupedStatementsData.wrappedValue : statementsData.wrappedValue) ?? []).enumerated()), id: \.offset) { index, item in
                VStack(spacing:0) {
                    HStack(spacing:0) {
                        VStack {
                            Text(convertDateString(item.postDate ?? "") ?? "")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                            
                            Text("\(item.symbol?.isEmpty ?? true ? "-" : item.symbol ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        }
                        
                        VStack {
                            Text("\(item.docName?.isEmpty == true ? "-" : (item.docName ?? "").getStatmentName(isJvCredit: ((item.crAmt ?? 0) > 0)))")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.qty ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        }
                        
                        VStack {
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.avgPrice ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                            
                            Text("\(AppUtility.shared.formatThousandSeparator(number: (((item.crAmt ?? 0) > 0) ? (item.crAmt ?? 0) : (item.dbAmt ?? 0))))")
                                .font(.apply(.semiBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                        }
                        
                        VStack {
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.balance ?? 0))")
                                .font(.apply(.semiBold, size: 14))
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .padding(.horizontal, 2)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                    .padding(.bottom ,6)
                    .padding(.horizontal, 15)
                }
            }
            
            Text("\("ending_balance".localized): \(statementsData.wrappedValue?.last?.balance ?? 0)")
                .font(.apply(.semiBold, size: 12))
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .padding(.horizontal, 14)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }
}


func convertDateString(_ input: String) -> String? {
    let pattern = #"Date\((\d+)([+-]\d{4})\)"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: input, range: NSRange(input.startIndex..., in: input)) else {
            return nil
        }
        
        guard let timestampRange = Range(match.range(at: 1), in: input),
              let timezoneRange = Range(match.range(at: 2), in: input) else {
            return nil
        }
        
        let timestampString = String(input[timestampRange])
        let timezoneString = String(input[timezoneRange])
        
        guard let milliseconds = Double(timestampString) else { return nil }
        let date = Date(timeIntervalSince1970: milliseconds / 1000)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        // Handle timezone manually
        let tzSign = timezoneString.hasPrefix("-") ? -1 : 1
        let tzHours = Int(timezoneString.dropFirst().prefix(2)) ?? 0
        let tzMinutes = Int(timezoneString.suffix(2)) ?? 0
        let totalOffset = tzSign * ((tzHours * 3600) + (tzMinutes * 60))
        formatter.timeZone = TimeZone(secondsFromGMT: totalOffset)
        
        return formatter.string(from: date)
}
