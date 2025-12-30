//
//  AlertsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct AlertsContentView: View {
    
    var alertsData:Binding<[GetAlertByUserCodeUIModel]?>
    
    @State var searchResult: String = ""
    
    var onBackTap: () -> Void
    var onAddTap:() -> Void
    
    var body: some View {
        VStack {
            headerView
            
            if alertsData.wrappedValue?.isEmpty == true {
                Spacer()
                contentView
                Spacer()
            } else {
                contentView
                Spacer()
            }
            
            Divider().padding(.vertical, 4)
            bottomButtonView
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
            
            Text("alerts".localized)
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
        VStack(spacing: 0) {
            if alertsData.wrappedValue?.isEmpty == true {
                VStack(spacing: 0) {
                    Image("ic_noAlerts")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    Text("no_added_alerts".localized)
                        .font(.apply(.medium, size: 16))
                }
            } else {
                VStack(spacing: 0) {
                    searchView
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(Array((alertsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                            if searchResult.isEmpty {
                                VStack(spacing: 0) {
                                    HStack {
                                        if UserDefaultController().isCompaniesLogoEnabled == true {
                                            WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol).jpg")) { phase in
                                                switch phase {
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .padding(.horizontal, 4)
                                                        .foregroundStyle(.gray)
                                                case .failure:
                                                    Image("ic_selectStock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .padding(.horizontal, 4)
                                                        .foregroundStyle(.gray)
                                                case .empty:
                                                    Image("ic_selectStock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .foregroundStyle(.gray)
                                                @unknown default:
                                                    Image("ic_selectStock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .foregroundStyle(.gray)
                                                }
                                            }
                                        }
                                        HStack {
                                            Text("\(AppUtility.shared.isRTL ? item.companyShortNameA ?? "" : item.companyShortNameE ?? "")")
                                                .font(.apply(.medium, size: 12))
//
                                            Text(" - ")
                                                .font(.apply(.medium, size: 12))
                                                .padding(.horizontal, 4)

                                            Text("\(item.symbol ?? "")")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)
                                            
                                        }
                                        .padding(.horizontal, 4)
                                                                                
                                        HStack {
                                            Text(convertDateString(item.validity ?? "") ?? "")
                                                .font(.apply(.regular, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)

                                            Image("ic_calendar")
                                                .renderingMode(.template)
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(Color.colorTextPrimary)
                                                .frame(width: 18, height: 18)
                                        }

                                     }
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 20)
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                        }
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        VStack {
                                            Text("value".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text("\(item.conditionValue ?? "")")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)

                                        VStack {
                                            Text("alert_no".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text("\(item.alertID ?? "")")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("price_factor".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.conditionName ?? "")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("state".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.executed ?? "")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorPositiveSecondary)
                                        }
                                        .frame(minWidth: 75.75)

                                    }
                                    .padding(.vertical, 8)
                                    .padding(.bottom, 4)
                                }
                                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                                .padding(.horizontal, 20)
                                
                            } else if !searchResult.isEmpty && (item.symbol ?? "").lowercased().contains(searchResult.lowercased()) {
                                VStack(spacing: 0) {
                                    HStack {
                                        if UserDefaultController().isCompaniesLogoEnabled == true {
                                            WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol).jpg")) { phase in
                                                switch phase {
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .padding(.horizontal, 4)
                                                        .foregroundStyle(.gray)
                                                case .failure:
                                                    Image("ic_selectStock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .padding(.horizontal, 4)
                                                        .foregroundStyle(.gray)
                                                case .empty:
                                                    Image("ic_selectStock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .foregroundStyle(.gray)
                                                @unknown default:
                                                    Image("ic_selectStock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25, maxHeight: 25)
                                                        .foregroundStyle(.gray)
                                                }
                                            }
                                        }
                                        HStack {
                                            Text("\(AppUtility.shared.isRTL ? item.companyShortNameA ?? "" : item.companyShortNameE ?? "")")
                                                .font(.apply(.medium, size: 12))
                                            
                                            Text(" - ")
                                                .font(.apply(.medium, size: 12))
                                                .padding(.horizontal, 4)
                                            
                                            Text("\(item.symbol ?? "")")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)
                                            
                                        }
                                        .padding(.horizontal, 4)
                                        
                                        HStack {
                                            Text(convertDateString(item.validity ?? "") ?? "")
                                                .font(.apply(.regular, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)
                                            
                                            Image("ic_calendar")
                                                .renderingMode(.template)
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(Color.colorTextPrimary)
                                                .frame(width: 18, height: 18)
                                        }
                                        
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 20)
                                    .frame(maxWidth: .infinity)
                                    .onTapGesture {
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        VStack {
                                            Text("value".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text("\(item.conditionValue ?? "")")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("alert_no".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text("\(item.alertID ?? "")")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("price_factor".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.conditionName ?? "")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("state".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.executed ?? "")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorPositiveSecondary)
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.bottom, 4)
                                }
                                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
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

    
    private var bottomButtonView: some View {
        Text("add_alert".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onAddTap()
            }
    }
    
    func convertDateString(_ input: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "ddMMyyyyHHmmss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: input) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return outputFormatter.string(from: date)
    }


}

