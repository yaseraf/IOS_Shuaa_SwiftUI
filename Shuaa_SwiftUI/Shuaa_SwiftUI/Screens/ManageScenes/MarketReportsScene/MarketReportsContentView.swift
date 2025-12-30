//
//  MarketReportsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/10/2025.
//

import Foundation
import SwiftUI

struct MarketReportsContentView: View {
    
    var reportsData:Binding<[DailyReportsUIModel]>
    
    enum ReportSectionType {
        case Monthly
        case Yearly
    }

    @State var selectedReportSection: ReportSectionType = .Monthly

    var onReportTap:(Int)->Void
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            headerView
            
            Divider()
            
            sectionsView
            
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
            
            Text("market_reports".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var sectionsView: some View {
        HStack(spacing: 0) {
            VStack(spacing: 16) {
                Text("monthly_reports".localized)
                    .font(.apply(selectedReportSection == .Monthly ? .semiBold : .regular, size: 14))
                    .foregroundStyle(selectedReportSection == .Monthly ? Color.colorPrimary : Color.colorTextSecondary)
                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedReportSection == .Monthly ? 1 : 0)
            }
            .onTapGesture {
                selectedReportSection = .Monthly
            }
            Spacer()
            VStack(spacing: 16) {
                Text("yearly_reports".localized)
                    .font(.apply(selectedReportSection == .Yearly ? .semiBold : .regular, size: 14))
                    .foregroundStyle(selectedReportSection == .Yearly ? Color.colorPrimary : Color.colorTextSecondary)
                Color.colorPrimary.frame(maxHeight: 2).opacity(selectedReportSection == .Yearly ? 1 : 0)
            }
            .onTapGesture {
                selectedReportSection = .Yearly
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }
    
    private var contentView: some View {
        VStack {
            ForEach(Array((reportsData.wrappedValue).enumerated()), id: \.offset) { index, item in
                Button {
                    onReportTap(index)
                } label: {
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.colorBG)
                            .overlay {
                                Image("ic_pdf")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        
                        Text(item.title)
                            .font(.apply(.semiBold, size: 12))
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.colorDocumentBG)
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
                        }
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)

                }
                .buttonStyle(.plain)

            }
        }
    }
    
}

#Preview {
    MarketReportsContentView(reportsData: .constant([]), onReportTap: { index in
        
    }, onBackTap: {
        
    })
}
