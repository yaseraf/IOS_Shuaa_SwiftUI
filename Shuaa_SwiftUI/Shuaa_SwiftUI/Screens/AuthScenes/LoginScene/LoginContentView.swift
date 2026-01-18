//
//  LoginView.swift
//  Shuaa_SwiftUI
//
//  Created by FIT on 16/07/2025.
//

import SwiftUI

struct LoginContentView: View {
    
    @State var isPasswordHidden:Bool = true
    
    var username:Binding<String>
    var password:Binding<String>
    
    var onChangeLanguage:()->Void
    var onSignUpTap:()->Void
    var onVideoTutorialTap:()->Void

    var body: some View {
        ZStack {
                
            Image(AppUtility.shared.isDarkTheme ? "splashNight" : "splashDay")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.dismissKeyboard()
                }

            VStack {
                headerView
                    .padding(.top, 20)
                
                titleView
                    .padding(.bottom, 85)
                
                inputFieldsView
                    .padding(.horizontal, 16)
                    .padding(.bottom, 65)

                
                signInView
                
                signUpView
                
                videoTutorialView
                
                Spacer()

            }
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 25) {
            Spacer()
            
            Button {
                onChangeLanguage()
            } label: {
                HStack {
                    Text(AppUtility.shared.isRTL ? "english".localized : "arabic".localized)
                        .font(.apply(size: 16))
                        .foregroundStyle(Color.white)
                }
                .padding(.horizontal, 18)
                .frame(maxHeight: 36)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var titleView: some View {
        VStack(spacing: 8) {
            Image(AppUtility.shared.isRTL ? "ic_logoAr" : "ic_logoEn")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 55)
        }
    }
    
    private var inputFieldsView: some View {
        return VStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.white)
                        .opacity(0.5)

                    Divider()
                        .frame(height: 24)
                        .overlay(Color.white)
                        .padding(.horizontal, 10)

                    TextField("", text: username, prompt: Text("username".localized).foregroundStyle(.white))
                        .font(.apply(.bold, size: 16))
                        .foregroundStyle(.white)
                        .frame(height: 50)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                .padding(.horizontal, 24)
                .background(
                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.5).fill(Color.white)
                )
                .frame(height: 50)
                .padding(.bottom, 16)
                
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 12, height: 16)
                        .foregroundStyle(.white)
                        .opacity(0.5)

                    Divider()
                        .frame(height: 24)
                        .overlay(Color.white)
                        .padding(.horizontal, 10)

                    if isPasswordHidden {
                        SecureField("", text: password, prompt: Text("password".localized).foregroundStyle(.white))
                            .font(.apply(.bold, size: 16))
                            .foregroundStyle(.white)
                            .frame(height: 50)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField("", text: password, prompt: Text("password".localized).foregroundStyle(.white))
                            .font(.apply(.bold, size: 16))
                            .foregroundStyle(.white)
                            .frame(height: 50)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                                            
                }
                .padding(.horizontal, 24)
                .background(
                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.5).fill(Color.white)
                )
                .frame(height: 50)
                .padding(.bottom, 8)

                HStack {
                    Button {
                        
                    } label: {
                        Text("forget_your_password".localized)
                            .font(.apply(.regular, size: 14))
                            .foregroundStyle(Color.white)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var signInView: some View {
        Button(action: {

            onSignUpTap()
        }, label: {
            Text("login".localized)
                .font(.apply(.regular, size: 18))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).opacity(0.5))
        })
        .padding(.horizontal, 145)
        .padding(.vertical, 16)
                
    }
    
    private var signUpView: some View {
        HStack {
            Text("no_account_yet".localized)
                .font(.apply(.regular, size: 16))
                .foregroundStyle(.white)
            Button {
                onSignUpTap()
            } label: {
                Text("join_us_now".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(.white)
            }

        }
    }
    
    private var videoTutorialView: some View {
        Button {
            onVideoTutorialTap()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "play.rectangle")
                    .resizable()
                    .frame(width: 18, height: 16)
                    .foregroundStyle(.white)
                    .opacity(0.5)

                Text("video_tutorial".localized)
                    .font(.apply(.regular, size: 16))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    LoginContentView(
        isPasswordHidden: false,
        username: .constant(""),
        password: .constant(""),
        onChangeLanguage: {
        
        },
        onSignUpTap: {
            
        },
        onVideoTutorialTap: {
            
        }
    )
}
