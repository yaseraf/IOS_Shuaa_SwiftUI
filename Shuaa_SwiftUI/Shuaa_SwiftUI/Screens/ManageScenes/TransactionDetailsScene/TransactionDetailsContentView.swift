//
//  TransactionDetailsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 07/08/2025.
//

import Foundation
import SwiftUI

struct TransactionDetailsContentView: View {
    
    var transactionAmount:Binding<String?>
    var fromAccount:Binding<String?>
    var status:Binding<TransactionStatus?>
    var statusDesc:Binding<String?>
    var transactionType:Binding<String?>
    var transactionDate:Binding<String?>
        
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            headerView
            
            detailsView
            
            Spacer()
            
            if status.wrappedValue == .pending {
                bottomButtonView
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
            
            Text("transaction_details".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    func parseASPDate(_ aspString: String) -> Date? {
        let cleaned = aspString
            .replacingOccurrences(of: "/Date(", with: "")
            .replacingOccurrences(of: ")/", with: "")
        
        // Ignore timezone for simplicity
        let parts = cleaned.split(separator: "+")
        let millisecondsString = parts[0].split(separator: "-")[0]
        
        guard let milliseconds = Double(millisecondsString) else { return nil }
        return Date(timeIntervalSince1970: milliseconds / 1000)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }


    private var detailsView: some View {
        VStack(spacing:0) {
            
            Image(status.wrappedValue == .approved ? "ic_approved" : status.wrappedValue == .pending ? "ic_pending" : status.wrappedValue == .rejected ? "ic_rejected" : status.wrappedValue == .underProcess ? "ic_underprocess" : "")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            
            HStack(spacing: 6) {
                Text(transactionAmount.wrappedValue ?? "")
                    .font(.apply(.bold, size: 31))
                
                Text(UserDefaultController().selectedUserAccount?.CUR_CODE ?? "")
                    .font(.apply(.semiBold, size: 24))
            }
            .environment(\.layoutDirection, AppUtility.shared.isRTL ? .rightToLeft : .leftToRight)
            
            VStack {
                HStack {
                    Text("from_account".localized)
                        .font(.apply(.regular, size: 14))
                    Spacer()
                    Text(fromAccount.wrappedValue ?? "")
                        .font(.apply(.medium, size: 14))
                }
                Divider()
                
                HStack {
                    Text("status".localized)
                        .font(.apply(.regular, size: 14))
                    Spacer()
                    Text("\(status.wrappedValue?.name ?? "")")
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(status.wrappedValue == .approved ? Color.colorPositiveSecondary : status.wrappedValue == .pending ? Color.colorPrimary : status.wrappedValue == .underProcess ? Color.colorPrimary : status.wrappedValue == .rejected ? Color.colorNegativeSecondary : Color.colorPrimary)
                }
                Divider()
                
                HStack {
                    Text("transaction_type".localized)
                        .font(.apply(.regular, size: 14))
                    Spacer()
                    Text("\(transactionType.wrappedValue ?? "")")
                        .font(.apply(.regular, size: 14))
                }
                Divider()
                
                HStack {
                    Text("date".localized)
                        .font(.apply(.regular, size: 14))
                    Spacer()
                    
                    if let date = parseASPDate(transactionDate.wrappedValue ?? "") {
                        Text("\(formatDate(date))")
                            .font(.apply(.regular, size: 14))
                    }
                }
                Divider()
                
                HStack {
                    Text("time".localized)
                        .font(.apply(.regular, size: 14))
                    Spacer()
                    if let date = parseASPDate(transactionDate.wrappedValue ?? "") {
                        Text("\(formatTime(date))")
                            .font(.apply(.regular, size: 14))
                    }
                }
                Divider()
            }
            .padding(.top, 16)
            .padding(.horizontal, 24)
            .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder))
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
    
    private var bottomButtonView: some View {
        Text("delete_transaction".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onBackTap()
            }
    }
}

enum TransationTypes {
    case a // Approved
    case p // Pending
    case u // Under Process
    case r // Rejected
    
    var foregroundColor:Color {
        switch self {
        case .a:
            Color.colorPositiveSecondary
        case .p:
            Color.colorPrimary
        case .u:
            Color.colorPrimary
        case .r:
            Color.colorNegativeSecondary
        }
    }
    
   
}



//func getForegroundColor(status: String) -> Color {
//    switch status.lowercased() {
//    case "a":
//        return TransationTypes.a.foregroundColor
//    case "p":
//        return TransationTypes.p.foregroundColor
//    case "u":
//        return TransationTypes.u.foregroundColor
//    case "r":
//        return TransationTypes.r.foregroundColor
//    default: return Color.red
//    }
//}
