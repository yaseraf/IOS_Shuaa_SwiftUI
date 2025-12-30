//
//  DocumentsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 17/08/2025.
//

import Foundation
import SwiftUI

struct DocumentsContentView: View {
    
    var documentsData:Binding<GetRequiredUserDocumentsUIModel?>
    var expiredDocumentsData:Binding<GetExpiredAttachmentUIModel?>
    
    var onDocumentTap:(String)->Void
    var onBackTap:() -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            ScrollView(.vertical, showsIndicators: false) {
                contentView
            }
            
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
            
            Text("documents".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            Text("uploaded_documents".localized)
                .font(.apply(.semiBold, size: 12))
            
            // Sort documents by expiry date (latest first)
            let sortedDocuments = (documentsData.wrappedValue?.backOfficeIDValidityResult ?? []).sorted { first, second in
//                guard let firstDate = parseDate(first.expiryDate), let secondDate = parseDate(second.expiryDate)
                guard let firstDate = first.expiryDate, let secondDate = second.expiryDate
                else {
                    return false
                }
                // Sort descending (latest date first)
                return firstDate > secondDate
            }
            
            let sortedExpiredDocuments = (expiredDocumentsData.wrappedValue?.backOfficeIDValidityResult ?? []).sorted { first, second in
//                guard let firstDate = parseDate(first.expiryDate), let secondDate = parseDate(second.expiryDate)
                guard let firstDate = first.expiryDate, let secondDate = second.expiryDate
                else {
                    return false
                }
                // Sort descending (latest date first)
                return firstDate > secondDate
            }
            
            ForEach(Array(sortedDocuments.enumerated()), id: \.offset) { index, item in
                VStack {
                    HStack(alignment: .top) {
                        Circle()
                            .fill(Color.colorBG)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image("ic_document")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.docType == "ID1" ? "QID" : "passport".localized)
                                .font(.apply(.semiBold, size: 12))
                            HStack(spacing: 0) {
                                Text("\("end_date".localized)")
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextSecondary)
//                                Text(formatDateString(item.expiryDate ?? ""))
                                Text(item.expiryDate ?? "")
                                    .font(.apply(.semiBold, size: 12))
                            }
                            HStack(spacing: 2) {
//                                Circle()
//                                    .fill(Color.colorPositiveSecondary)
//                                    .frame(width: 20, height: 20)
//                                    .overlay {
//                                        Image("ic_tick")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .foregroundStyle(Color.colorBG)
//                                            .frame(width: 12, height: 12)
//                                    }
                                
                                Text(isDocumentExpired(from: item.expiryDate ?? "") ? "expired".localized : "active".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(isDocumentExpired(from: item.expiryDate ?? "") ? Color.colorNegativeSecondary : Color.colorPositiveSecondary)
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            onDocumentTap(item.idNumber ?? "")
                        } label: {
                            Image("ic_uploadContent")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }

                    }
                    
//                    HStack {
//                        Image("ic_documentDemoFront")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity)
//                            .frame(minHeight: 91)
//                        Image("ic_documentDemoBack")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity)
//                            .frame(minHeight: 91)
//                    }
                }
                .padding(16)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12).fill(Color.colorDocumentBG)
                        RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
            }
            
            ForEach(Array(sortedExpiredDocuments.enumerated()), id: \.offset) { index, item in
                VStack {
                    HStack(alignment: .top) {
                        Circle()
                            .fill(Color.colorBG)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image("ic_document")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.docType == "ID1" ? "QID" : "passport".localized)
                                .font(.apply(.semiBold, size: 12))
                            HStack(spacing: 0) {
                                Text("\("end_date".localized)")
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(Color.colorTextSecondary)
//                                Text(formatDateString(item.expiryDate ?? ""))
                                Text(item.expiryDate ?? "")
                                    .font(.apply(.semiBold, size: 12))
                            }
                            HStack(spacing: 2) {
//                                Circle()
//                                    .fill(Color.colorPositiveSecondary)
//                                    .frame(width: 20, height: 20)
//                                    .overlay {
//                                        Image("ic_tick")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .foregroundStyle(Color.colorBG)
//                                            .frame(width: 12, height: 12)
//                                    }
                                
                                Text(isDocumentExpired(from: item.expiryDate ?? "") ? "expired".localized : "active".localized)
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(isDocumentExpired(from: item.expiryDate ?? "") ? Color.colorNegativeSecondary : Color.colorPositiveSecondary)
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            onDocumentTap(item.idNumber ?? "")
                        } label: {
                            Image("ic_uploadContent")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }

                    }
                    
//                    HStack {
//                        Image("ic_documentDemoFront")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity)
//                            .frame(minHeight: 91)
//                        Image("ic_documentDemoBack")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity)
//                            .frame(minHeight: 91)
//                    }
                }
                .padding(16)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12).fill(Color.colorDocumentBG)
                        RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
                    }
                )
            }

        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
    
    func formatDateString(_ input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy" // your input format
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy" // desired output format

        if let date = inputFormatter.date(from: input) {
            return outputFormatter.string(from: date)
        } else {
            print("❌ Failed to parse date:", input)
            return ""
        }
    }

    private func parseDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")

        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"

        if let date = formatter.date(from: dateString) {
            return date
        }

        print("❌ Could not parse date:", dateString)
        return nil
    }

    func isDocumentExpired(from dateString: String) -> Bool {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            guard let expiryDate = formatter.date(from: dateString) else {
                return true
            }

            let currentDate = Date()
            
            if expiryDate > currentDate {
                return false
            } else {
                return true
            }
    }
}
