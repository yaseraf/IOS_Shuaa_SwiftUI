//
//  SettingContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/07/2025.
//

import Foundation
import SwiftUI

struct SettingContentView: View {
    
    enum languages {
        case arabic
        case english
    }
    
    @State var selectedLanguage: languages = .english
    
    @Binding var themeToggle:Bool
    var companiesLogoToggle:Binding<Bool>
    var classificationBySectorToggle:Binding<Bool>
    var biometricLoginToggle:Binding<Bool>
    var pinLoginToggle:Binding<Bool>

    var onBackTap:() -> Void
    var onLanguageSelected:()->Void
    var onDarkThemeToggle:(Bool)->Void
    var onCompaniesLogoToggle:(Bool)->Void
    var onClassificationBySectorToggle:(Bool)->Void
    var onBiometricLoginToggle:(Bool)->Void
    var onPinLoginToggle:(Bool)->Void
    
    var body: some View {
        VStack {
            
            headerView
            
            Spacer().frame(height: 20)
            
            contentView
            
            Spacer()
        }
        .onAppear {
            if UserDefaultController().appLanguage == "ar" {
                selectedLanguage = .arabic
            } else {
                selectedLanguage = .english
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
            
            Text("setting".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(.horizontal, 24)
    }
    
    private var contentView: some View {
        VStack(spacing:16) {
            
            // Select Language
            VStack {
                HStack {
                    Text("select_language".localized)
                        .font(.apply(.semiBold, size: 14))

                    Spacer()
                }
                
                HStack {
                    Text("English Language")
                        .foregroundStyle(selectedLanguage == .english ? Color.white : Color.colorTextPrimary)
                        .font(.apply(.regular, size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(
//                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8).fill(selectedLanguage == .english ? Color.colorPrimary : .clear)
                                
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedLanguage == .english ? Color.colorPrimary : Color.colorBorder)
                            }
                        )
                        .onTapGesture {
                            AppUtility.shared.updateAppLanguage(language: .english)
                            selectedLanguage = .english
                            onLanguageSelected()
                        }
                    
                    Spacer()

                    Text("arabic_language".localized)
                        .foregroundStyle(selectedLanguage == .arabic ? Color.white : Color.colorTextPrimary)
                        .font(.apply(.regular, size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(
//                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8).fill(selectedLanguage == .arabic ? Color.colorPrimary : .clear)
                                
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedLanguage == .arabic ? Color.colorPrimary : Color.colorBorder)
                            }
                        )
                        .onTapGesture {
                            AppUtility.shared.updateAppLanguage(language: .arabic)
                            selectedLanguage = .arabic
                            onLanguageSelected()
                        }
                }
//                .padding(.top, 4)
            }
            
            // Font Size
//            HStack {
//                Text("font_size".localized)
//                    .font(.apply(.semiBold, size: 14))
//
//                Spacer()
//                
//                HStack(spacing: 10) {
//                    Text("-")
//                        .font(.apply(.medium, size: 14))
//
//                    Text("13.0")
//                        .font(.apply(.medium, size: 14))
//
//                    Text("+")
//                        .font(.apply(.medium, size: 14))
//                }
//                .padding(.horizontal, 10)
//                .frame(height: 24)
//                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))
//                
//            }
//            .padding(.horizontal, 16)
//            .frame(height: 56)
//            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))
            
            // Theme
            HStack {
                Text("dark_theme".localized)
                    .font(.apply(.semiBold, size: 14))

                Spacer()
                
                Toggle("", isOn: $themeToggle)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                    .onChange(of: themeToggle) { newValue in
                        onDarkThemeToggle(newValue)
                    }

            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))
            
            // Companies Logo
            HStack {
                Text("companies_logo".localized)
                    .font(.apply(.semiBold, size: 14))

                Spacer()
                
                Toggle("", isOn: companiesLogoToggle)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                    .onChange(of: companiesLogoToggle.wrappedValue) { newValue in
                        onCompaniesLogoToggle(newValue)
                    }
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))
            
            // Classification By Sector
            HStack {
                Text("classification_by_sector".localized)
                    .font(.apply(.semiBold, size: 14))

                Spacer()
                
                Toggle("", isOn: classificationBySectorToggle)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                    .onChange(of: classificationBySectorToggle.wrappedValue) { newValue in
                        onClassificationBySectorToggle(newValue)
                    }

            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))
            
            // Biometric Login
            HStack {
                Text("biometric_login".localized)
                    .font(.apply(.semiBold, size: 14))

                Spacer()
                
                Toggle("", isOn: biometricLoginToggle)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                    .onChange(of: biometricLoginToggle.wrappedValue) { newValue in
                        onBiometricLoginToggle(newValue)
                    }

            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))
            
            // Pin Login
            HStack {
                Text("pin_login".localized)
                    .font(.apply(.semiBold, size: 14))

                Spacer()
                
                Toggle("", isOn: pinLoginToggle)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.colorPrimary))
                    .onChange(of: pinLoginToggle.wrappedValue) { newValue in
                        onPinLoginToggle(newValue)
                    }

            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))

            
            // App Version
            HStack {
                Text("application_version_number".localized)
                    .foregroundStyle(Color.colorTextPrimary)
                    .font(.apply(.bold, size: 14))

                Spacer()
                
                Text("\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")")
                    .foregroundStyle(Color.colorTextPrimary)
                    .font(.apply(.bold, size: 14))

            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundStyle(Color.colorBorder))

        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
}
