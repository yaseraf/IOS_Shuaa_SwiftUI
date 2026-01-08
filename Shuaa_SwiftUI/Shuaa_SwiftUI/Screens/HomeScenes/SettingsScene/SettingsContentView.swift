//
//  ManageContentView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 27/07/2025.
//

import Foundation
import SwiftUI

struct SettingsContentView:View {
        
    @State var notificationToggle = false
    @State var loginWithBiometricToggle = false
    @State var enableRotationToggle = false
    @State var appModeToggle = false
    
    var fontSize:Binding<Int?>
    var selectedLanguage:Binding<LanguageType>
    var selectedTheme:Binding<ThemeType>
    
    var onLanguageChange:((LanguageType)->Void)
    var onAppThemeChange:((ThemeType)->Void)
    var onFontSizeIncrease:()->Void
    var onFontSizeDecrease:()->Void
    
    var body: some View {
        VStack {

            SharedHeaderView(withBackButton: true)

            titleView
            
            ScrollView(showsIndicators: false) {
                tabsView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
            
        }
    }
    
    private var titleView: some View {
        HStack {
            Text("settings".localized)
                .font(.apply(.bold, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
                .padding(.vertical, 4)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

    }
    
    private var tabsView: some View {
        VStack(spacing: 16) {
            
            // MARK: App Language
            HStack {
                Text("app_language".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)

                Spacer()
                
                HStack {
                    Button {
                        onLanguageChange(.arabic)
                    } label: {
                        Text("arabic".localized)
                            .font(.apply(.medium, size: 16))
                            .foregroundStyle(selectedLanguage.wrappedValue == .arabic ? Color.colorBase : Color.colorTextPrimary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(selectedLanguage.wrappedValue == .arabic ? Color.colorTextPrimary : Color.colorBackgroundSecondary)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorTextPrimary)
                                }
                            )
                    }


                    Button {
                        onLanguageChange(.english)
                    } label: {
                        Text("english".localized)
                            .font(.apply(.medium, size: 16))
                            .foregroundStyle(selectedLanguage.wrappedValue == .english ? Color.colorBase : Color.colorTextPrimary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(selectedLanguage.wrappedValue == .english ? Color.colorTextPrimary : Color.colorBackgroundSecondary)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorTextPrimary)
                                }
                            )
                    }

                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))
            
            // MARK: Preferred Language
            HStack {
                Text("preferred_language".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)

                Spacer()
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("arabic".localized)
                            .font(.apply(.medium, size: 16))
                            .foregroundStyle(selectedLanguage.wrappedValue == .arabic ? Color.colorBase : Color.colorTextPrimary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(selectedLanguage.wrappedValue == .arabic ? Color.colorTextPrimary : Color.colorBackgroundSecondary)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorTextPrimary)
                                }
                            )
                    }

                    Button {
                        
                    } label: {
                        Text("english".localized)
                            .font(.apply(.medium, size: 16))
                            .foregroundStyle(selectedLanguage.wrappedValue == .english ? Color.colorBase : Color.colorTextPrimary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(selectedLanguage.wrappedValue == .english ? Color.colorTextPrimary : Color.colorBackgroundSecondary)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorTextPrimary)
                                }
                            )
                    }

                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))

            // MARK: Notification
            HStack {
                Text("notification".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)

                Spacer()
                
                Toggle(isOn: $notificationToggle, label: {})
                    .tint(Color.colorPrimary)
                    
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))

            // MARK: Login with Biometric ID
            HStack {
                Text("login_with_biometric_id".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)
                
                Spacer()
                
                Toggle(isOn: $loginWithBiometricToggle, label: {})
                    .tint(Color.colorPrimary)
                    
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))

            // MARK: Enable Rotation
            HStack {
                Text("enable_rotation".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)
                
                Spacer()
                
                Toggle(isOn: $enableRotationToggle, label: {})
                    .tint(Color.colorPrimary)
                    
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))

            // MARK: Font Size
            HStack {
                Text("font_size".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)
                
                Spacer()
                
                HStack {
                    Button {
                        onFontSizeDecrease()
                    } label: {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(Color.colorTextPrimary)
                            .frame(width: 24, height: 24)
                            .overlay {
                                Color.colorTextPrimary
                                    .frame(width: 12, height: 2)
                                    .cornerRadius(24)
                            }
                    }

                    Text("\(fontSize.wrappedValue ?? 0)")
                        .font(.apply(.medium, size: 12))
                        .foregroundStyle(Color.colorTextPrimary)

                    Button {
                        onFontSizeIncrease()
                    } label: {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(Color.colorTextPrimary)
                            .frame(width: 24, height: 24)
                            .overlay {
                                Text("+")
                                    .font(.apply(.medium, size: 24))
                                    .foregroundStyle(Color.colorTextPrimary)
                            }
                    }

                        
                }
                    
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))
            
            // MARK: App Theme Mode
            HStack(alignment: appModeToggle == false ? .center : .top) {
                Text("app_theme_mode".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)

                Spacer()
                
                VStack {
                    Button {
                        appModeToggle.toggle()
                    } label: {
                        Text(selectedTheme.wrappedValue == .dark ? "dark".localized : "light".localized)
                            .font(.apply(.medium, size: 18))
                            .foregroundStyle(Color.colorBase)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 4)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8).fill(Color.colorTextPrimary)
                                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorTextPrimary)
                                }
                            )
                    }
                    
                    if appModeToggle {
                        Button {
                            appModeToggle.toggle()
                            
                            onAppThemeChange(selectedTheme.wrappedValue == .dark ? .light : .dark)
                        } label: {
                            Text(selectedTheme.wrappedValue == .dark ? "light".localized : "dark".localized)
                                .font(.apply(.medium, size: 18))
                                .foregroundStyle(Color.colorTextPrimary)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 4)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary)
                                        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorTextPrimary)
                                    }
                                )
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))

            // MARK: Change Password
            HStack {
                Image("ic_passwordLock")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 22)
                    .foregroundStyle(Color.colorSymbolPrimary)

                Text("change_password".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(Color.colorTextPrimary)
                    .minimumScaleFactor(0.9)
                    .lineLimit(1)
                
                Spacer()
                

                Button {
                    
                } label: {
                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(Color.colorSymbolPrimary)

                }

            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.colorBackgroundSecondary))

        }
        .frame(maxWidth: .infinity)

    }
    
}

#Preview {
    SettingsContentView(fontSize: .constant(0), selectedLanguage: .constant(.english), selectedTheme: .constant(.dark), onLanguageChange: { _ in
        
    }, onAppThemeChange: { _ in
        
    }, onFontSizeIncrease: {
        
    }, onFontSizeDecrease: {
        
    })
}
