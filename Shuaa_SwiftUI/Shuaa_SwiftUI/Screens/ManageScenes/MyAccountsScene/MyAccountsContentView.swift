//
//  CashInContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 31/07/2025.
//

import Foundation
import SwiftUI

struct MyAccountsContentView: View {
    
    enum OperationType {
        case createAccount
        case myAccounts
    }
    
    @State var operationType: OperationType = .myAccounts
    @State var operationTypeindex: Int = 0
    
    var selectedCountry:Binding<CountryUIModel?>
    var selectedBank:Binding<GetBankIBANUIModel?>
    var myAccounts:Binding<[AccountsUIModel]?>
    
    @State var amount:String = ""
    
    @State var hasDetailsExpanded = false
    @State var selectedAccount: AccountsUIModel?
    
    var onBackTap: () -> Void
    var onSendTap: () -> Void
    var onBankAccountTap: () -> Void
    var onCountryTap: () -> Void
    var onUploadFileTap: () -> Void
    

    var body: some View {
        VStack {
            headerView
            
            segmentedControlView
            
//            if operationTypeindex == 0 {
//                createAccountContentView
//            } else if operationTypeindex == 1 {
//                myAccountsContentView
//            }
            
            myAccountsContentView
            
            Spacer()
            
//            if operationTypeindex == 0 {
//
//                bottomButtonView
//            }
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
            
            Text("my_accounts".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var segmentedControlView: some View {
//        CustomSegmentedControl(selectedIndex: $operationTypeindex, segments: ["create_account".localized, "my_accounts".localized])
        CustomSegmentedControl(selectedIndex: $operationTypeindex, segments: ["my_accounts".localized])
    }
    
    private var createAccountContentView: some View {
        var uploadFileAttribute: AttributedString {
            var str = AttributedString("upload_file".localized)
            str.underlineStyle = .single
            return str
        }
        
        return VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("country_name".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    Text((selectedCountry.wrappedValue != nil) ? "\(selectedCountry.wrappedValue?.countryName ?? "")" : "select_your_country".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onCountryTap()
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("please_select_your_bank".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    Text((selectedBank.wrappedValue != nil) ? " \(selectedBank.wrappedValue?.bankName ?? "") / \(String(selectedBank.wrappedValue?.bankAccNo?.suffix(5) ?? ""))" : "please_select_your_bank".localized)
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onBankAccountTap()
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("iban".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("please_enter_your_iban".localized, text: $amount)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("upload_iban_certificate".localized)
                    .font(.apply(.semiBold, size: 14))
                
                VStack {
                    Image("ic_upload")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    HStack {
                        Text("\("please_upload_iban_certificate".localized), ")
                            .font(.apply(.medium, size: 14))
                        
                        Text("\(uploadFileAttribute)")
                            .font(.apply(.medium, size: 14))
                            .foregroundStyle(Color.colorPrimary)
                            .onTapGesture {
                                onUploadFileTap()
                            }
                    }
                    
                    Text("\("supported_files".localized): JPG,PDF")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Text("(\("max_file_size".localized): 25 MB)")
                        .font(.apply(.medium, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)

                }
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var myAccountsContentView: some View {
        VStack {
            if myAccounts.wrappedValue?.isEmpty == true {
                Image("ic_noAccounts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                Text("no_accounts_create_an_account".localized)
                    .font(.apply(.medium, size: 16))
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 15) {
                        ForEach(Array((myAccounts.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                            VStack {
                                HStack {
                                    HStack {
                                        Image(item.logo ?? "")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                        
                                        Text(AppUtility.shared.isRTL ? item.accountNameA ?? "" : item.accountNameE ?? "")
                                            .font(.apply(.medium, size: 12))
                                    }
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 4) {
                                        Circle()
                                            .fill(item.status?.lowercased() == "active" ? Color.colorPositive : Color.colorNegative)
                                            .frame(width: 10, height: 10)
                                        
                                        Text("\(item.status ?? "")")
                                            .font(.apply(.regular, size: 12))
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 19).fill(item.status?.lowercased() == "active" ? Color.colorBGPositive : Color.colorBGNegative))
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 0) {
                                        Text("details".localized)
                                            .font(.apply(.regular, size: 14))
                                            .foregroundStyle(Color.colorPrimary)
                                        
                                        Image("ic_downArrow")
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(Color.colorPrimary)
                                            .frame(width: 12, height: 12)
                                    }
                                    .onTapGesture {
                                        hasDetailsExpanded.toggle()
                                        selectedAccount = item
                                    }
                                }
                                
                                if hasDetailsExpanded && selectedAccount?.iban == item.iban ?? "" {
                                    Divider()
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("swift_code".localized)
                                            .font(.apply(.semiBold, size: 12))
                                        
                                        TextField("please_enter_your_swift_code".localized, text: .constant(item.swiftCode ?? ""))
                                            .font(.apply(.regular, size: 14))
                                            .padding(.horizontal, 16)
                                            .frame(height: 56)
                                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                                            .padding(.bottom, 8)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("iban".localized)
                                            .font(.apply(.semiBold, size: 12))
                                        
                                        TextField("please_enter_your_iban".localized, text: .constant(item.iban ?? ""))
                                            .font(.apply(.regular, size: 14))
                                            .padding(.horizontal, 16)
                                            .frame(height: 56)
                                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                                            .padding(.bottom, 8)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("state".localized)
                                            .font(.apply(.semiBold, size: 12))
                                        
                                        TextField("please_enter_your_state".localized, text: .constant(AppUtility.shared.isRTL ? item.stateA ?? "" : item.stateE ?? ""))
                                            .font(.apply(.regular, size: 14))
                                            .padding(.horizontal, 16)
                                            .frame(height: 56)
                                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                                            .padding(.bottom, 8)
                                    }
                                    
                                    HStack {
                                        Text("delete".localized)
                                            .font(.apply(.medium, size: 14))
                                            .foregroundStyle(Color.colorNegativeSecondary)
                                            .padding(12)
                                            .frame(maxWidth: .infinity)
                                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorBorder))
                                        
                                        Text("edit".localized)
                                            .font(.apply(.medium, size: 14))
                                            .foregroundStyle(Color.white)
                                            .padding(12)
                                            .frame(maxWidth: .infinity)
                                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
                                    }
                                }
                                
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
    }
    
    private var bottomButtonView: some View {
        Text("create_account".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onSendTap()
            }
    }

}
