//
//  AccountInformationContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI

struct AccountInformationContentView:View {
        
    var accountInformationData:Binding<AccountInformationUIModel?>
    
    @State var accountInformationDataFontSize: CGFloat = 12
    
    var body: some View {
        VStack {
            SharedHeaderView(withBackButton: true)
            
            contentView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: UserDefaultController().selectedBottomTab ?? .home)
        }
        .background(Color.colorBackground) // Debug
    }
        
    private var contentView: some View {
        ZStack {
            
            Color.colorBackgroundSecondary
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(14)
                .padding(.horizontal, 12)
                .padding(.top, 64)
                .padding(.bottom, 12)

            VStack {
                Circle()
                    .stroke(lineWidth: 4)
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .background(Circle().fill(Color.colorBackgroundSecondary))
                    .foregroundStyle(Color.colorBackground)
                    .overlay {
                        Image("ic_person")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Image("ic_downArrow")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                    .padding(.horizontal,12)
                    .overlay {
                        Text("\(accountInformationData.wrappedValue?.name ?? "")")
                            .font(.apply(.regular, size: 12))
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1).fill(Color.colorTextPrimary))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 6)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\("client_id".localized):")
                            .font(.apply(.bold, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        Text("\("full_name".localized):")
                            .font(.apply(.bold, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        Text("\("phone_number".localized):")
                            .font(.apply(.bold, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        Text("\("email".localized):")
                            .font(.apply(.bold, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        Text("\("nin_dfm".localized):")
                            .font(.apply(.bold, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                        Text("\("trading_account_dfm".localized):")
                            .font(.apply(.bold, size: 14))
                            .foregroundStyle(Color.colorTextPrimary)
                    }
                    
//                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(accountInformationData.wrappedValue?.clientID ?? "")")
                            .font(.apply(.regular, size: accountInformationDataFontSize))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(minHeight: 18)

                        Text("\(accountInformationData.wrappedValue?.fullName ?? "")")
                            .font(.apply(.regular, size: accountInformationDataFontSize))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(minHeight: 18)

                        Text("\(accountInformationData.wrappedValue?.phoneNumber ?? "")")
                            .font(.apply(.regular, size: accountInformationDataFontSize))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(minHeight: 18)

                        Text("\(accountInformationData.wrappedValue?.email ?? "")")
                            .font(.apply(.regular, size: accountInformationDataFontSize))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(minHeight: 18)

                        Text("\(accountInformationData.wrappedValue?.nin ?? "")")
                            .font(.apply(.regular, size: accountInformationDataFontSize))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(minHeight: 18)

                        Text("\(accountInformationData.wrappedValue?.tradingAccount ?? "")")
                            .font(.apply(.regular, size: accountInformationDataFontSize))
                            .foregroundStyle(Color.colorTextPrimary)
                            .frame(minHeight: 18)
                        
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 18)

        }
    }
}

#Preview {
    AccountInformationContentView(
        accountInformationData: .constant(.initMockData())
    )
}
