//
//  ContactUsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 10/08/2025.
//

import Foundation
import SwiftUI

struct ContactUsContentView: View {
    
    var onBackTap:()->Void
    
    var body: some View {
        VStack(spacing: 16) {
            headerView
            
            headOfficeView
            
            technicalSupportAndCustomerServiceView
            
            companyLocationView
            
            companyWebsiteView
            
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
            
            Text("contact_us".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var headOfficeView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("head_office".localized)
                    .font(.apply(.semiBold, size: 14))
                
                Divider()
                
                HStack {
                    Image("ic_phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("(+974)44410062")
                        .font(.apply(.regular, size: 14))
                }
                
                HStack {
                    Image("ic_phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("(+974)44410067")
                        .font(.apply(.regular, size: 14))
                }
            }
            .padding(16)
            
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
        .padding(.horizontal, 20)
    }
    
    private var technicalSupportAndCustomerServiceView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("technical_support_and_customer_service".localized)
                    .font(.apply(.semiBold, size: 14))
                
                Divider()
                
                HStack {
                    Image("ic_phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("(+974)44255273")
                        .font(.apply(.regular, size: 14))
                }
                
                HStack {
                    Image("ic_phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("(+974)44255282")
                        .font(.apply(.regular, size: 14))
                }
                
                HStack {
                    Image("ic_phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("(+974)44255281")
                        .font(.apply(.regular, size: 14))
                }
                
                HStack {
                    Image("ic_mail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("info@qsc.qa")
                        .font(.apply(.regular, size: 14))
                }
            }
            .padding(16)

        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
        .padding(.horizontal, 20)
    }
    
    private var companyLocationView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("company_location".localized)
                        .font(.apply(.semiBold, size: 14))
                    
                    Spacer()
                    
                    HStack {
                        Image("ic_googleLocationPin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 20)
                        
                        Text("location_in_map".localized)
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(Color.colorPrimary)
                    }
                }
                
                Divider()
                
                HStack(alignment: .top) {
                    Image("ic_locationPin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("Fourth Ring Road Opposite Al Sharq Newspaper P.O. Box 33083 Doha - Qatar.")
                        .font(.apply(.regular, size: 14))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(0)
                }
            }
            .padding(16)
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
        .padding(.horizontal, 20)
    }
    
    private var companyWebsiteView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("company_website".localized)
                    .font(.apply(.semiBold, size: 14))
                
                Divider()
                
                HStack {
                    Image("ic_mail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("info@qsc.qa")
                        .font(.apply(.regular, size: 14))
                }
            }
            .padding(16)
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
        .padding(.horizontal, 20)
    }

}
