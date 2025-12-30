//
//  ShareDetailsTradesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import Foundation
import SwiftUI

struct ShareDetailsTradesContentView: View {
    
    var wholeShareTradesData:Binding<[GetSymbolTradesFullObjectUIModel]?>
    var shareTradesSummaryData:Binding<[SendSymbolTradesSummaryObjectUIModel]?>
    
    @State var isWholeShareTradesExpanded: Bool = false
    @State var isShareTradesSummaryExpanded: Bool = false
    
    func extractTime(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.dateFormat = "HH:mm:ss"

        return outputFormatter.string(from: date)
    }

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("whole_share_trades".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.colorBGSecondary)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .onTapGesture {
                    withAnimation {
                        isWholeShareTradesExpanded.toggle()
                    }
                }
                
                if isWholeShareTradesExpanded {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("price".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("quantity".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("value".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )
                            
                            Text("change".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("change_perc".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("time".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("type".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )
                        }
                        .background(Color.colorBGThird)

                        ForEach(Array((wholeShareTradesData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                            HStack(spacing: 0) {
                                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.price ?? "") ?? 0))")
                                    .font(.apply(.regular, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.volume ?? "") ?? 0))")
                                    .font(.apply(.regular, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                                Text("\((item.value ?? 0) >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: item.value ?? 0))")
                                    .font(.apply(.regular, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 4)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                                Text("\((Double(item.netChange ?? "") ?? 0) >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.netChange ?? "") ?? 0))")
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle((Double(item.netChange ?? "") ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                                
                                Text("\((Double(item.netChgPerc ?? "") ?? 0) >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(item.netChgPerc ?? "") ?? 0))%")
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle((Double(item.netChgPerc ?? "") ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                                
                                Text("\(extractTime(from: item.lastUpdateTime ?? "") ?? "")")
                                    .font(.apply(.regular, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                                
                                Text("\(item.sellBuyFlag?.lowercased() == "b" ? "buy".localized : "sell".localized)")
                                    .font(.apply(.regular, size: 12))
                                    .foregroundStyle(item.sellBuyFlag?.lowercased() == "b" ? Color.colorPositive : Color.colorNegative)
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                            }
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)

                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth:1).fill(Color.colorBorderSecondary))
                }
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("share_trades_summary".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)

                    Spacer()
                    
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.colorBGSecondary)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .onTapGesture {
                    withAnimation {
                        isShareTradesSummaryExpanded.toggle()
                    }
                }
                
                if isShareTradesSummaryExpanded {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("price".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("total_quantity".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )

                            Text("no_of_trades".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )
                            
                            Text("value".localized)
                                .font(.apply(.regular, size: 10))
                                .foregroundStyle(Color.colorTextSecondary)
                                .frame(minHeight: 40)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Rectangle().fill(Color.colorBGTable)
                                        Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary)
                                    }
                                )
                        }
                        .background(Color.colorBGThird)

                        ForEach(Array((shareTradesSummaryData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                            HStack(spacing: 0) {
                                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Price ?? "") ?? 0))")
                                    .font(.apply(.medium, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Volume ?? "") ?? 0))")
                                    .font(.apply(.medium, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.TrdNo ?? 0) ?? 0))")
                                    .font(.apply(.medium, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))

                                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(item.Value ?? 0) ?? 0))")
                                    .font(.apply(.medium, size: 12))
                                    .frame(minHeight: 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Rectangle().stroke(lineWidth: 1).fill(Color.colorBorderSecondary))
                            }

                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth:1).fill(Color.colorBorderSecondary))
                }
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }
}
