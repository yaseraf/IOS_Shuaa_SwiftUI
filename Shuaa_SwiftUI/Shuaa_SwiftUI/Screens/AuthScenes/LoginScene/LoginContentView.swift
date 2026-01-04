//
//  LoginView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/07/2025.
//

import SwiftUI

struct LoginContentView: View {
    
    var showMessagePopUp:Binding<Bool>
    var loginMessage:Binding<String>
    var username:Binding<String>
    var password:Binding<String>
    @State var isPasswordHidden:Bool = true

    var isRememberMe:Binding<Bool>
    var showAlert:Binding<Bool>
    var loginData:Binding<LoginUIModel?>
    
    var onSignInTap:((_ username: String, _ password: String, _ isRememberMe: Bool) -> Void)
    var onForgotNameTap:()->Void
    var onForgotPasswordTap:()->Void
    var onChangeLanguage:()->Void
    var onIsRememberMeTap:()->Void
    var onSetPin:(String, String)->Void
    var onFaceIDTap:(String, String)->Void
    var onReLoginTap:((_ username: String, _ password: String, _ isRememberMe: Bool) -> Void)
    
    var onSignUpTap:()->Void
    var onVideoTutorialTap:()->Void

    var body: some View {
        ZStack {
                
            Image("loginBackground")
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
            
            if showMessagePopUp.wrappedValue == true {
                ZStack {
                    
                }
                .alert("",
                       isPresented: showMessagePopUp) {
                    Button("yes".localized) {
                        onReLoginTap(
                            username.wrappedValue,
                            password.wrappedValue,
                            isRememberMe.wrappedValue
                        )
                    }
                    Button("cancel".localized) {
                        showMessagePopUp.wrappedValue = false
                    }
                } message: {
                    Text(loginMessage.wrappedValue)   // or any message you want
                }

                
//                .alert(loginMessage.wrappedValue, isPresented: showMessagePopUp) {
//                    Button("yes".localized) {
////                        if let url = URL(string: UserDefaultController().appstoreUrl ?? ""),
////                            UIApplication.shared.canOpenURL(url) {
////                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
////                        }
//                    }
//                    Button("cancel".localized) {
//                        showMessagePopUp.wrappedValue = false
//                    }
//                }

            }
        }
//        .ignoresSafeArea(.keyboard)
        .alert("please_choose_your_second_security_validation".localized, isPresented: showAlert) {
            Button {
                onFaceIDTap(username.wrappedValue, password.wrappedValue)
            } label: {
                Text("face_id".localized)
                    .font(.apply(.medium, size: 16))
            }
            
            Button {
                onSetPin(username.wrappedValue, password.wrappedValue)
            } label: {
                Text("pin".localized)
                    .font(.apply(.medium, size: 16))
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
                    Text("language".localized)
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
            Image(AppUtility.shared.isRTL ? "ic_logAr" : "ic_logoEn")
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
                        .foregroundStyle(.gray)
                    
                    Divider()
                        .frame(height: 24)
                        .overlay(Color.white)
                        .padding(.horizontal, 10)

                    TextField("", text: username, prompt: Text("username".localized).foregroundStyle(.white))
                        .font(.applyPTSans(.bold, size: 16))
                        .foregroundStyle(.white)
                        .frame(height: 50)
//                        .padding(.horizontal, 16)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                .padding(.horizontal, 24)
                .background(
                    ZStack {
                        if username.wrappedValue.isEmpty == true {
                            RoundedRectangle(cornerRadius: 8).fill(Color.clear)
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder)
                        } else {
                            if loginData.wrappedValue?.status == "-1" {
                                RoundedRectangle(cornerRadius: 8).fill(Color.clear)
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorNegativeSecondary)
                            } else {
                                RoundedRectangle(cornerRadius: 8).fill(Color.colorPrimary.opacity(0.04))
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorPrimary)
                            }
                        }
                    }
                )
                .frame(height: 50)
                .padding(.bottom, 16)


//                if loginData.wrappedValue?.status == "-1" {
//                    HStack {
//                        Image("ic_alert")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 15, height: 15)
//                        
//                        Text("wrong_user_name".localized)
//                            .font(.apply(size: 12))
//                            .foregroundStyle(Color.colorNegativeSecondary)
//                    }
//                }
                
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 12, height: 16)
                        .foregroundStyle(.gray)

                    Divider()
                        .frame(height: 24)
                        .overlay(Color.white)
                        .padding(.horizontal, 10)

                    if isPasswordHidden {
                        SecureField("", text: password, prompt: Text("password".localized).foregroundStyle(.white))
                            .font(.applyPTSans(.bold, size: 16))
                            .foregroundStyle(.white)
                            .frame(height: 50)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField("", text: password, prompt: Text("password".localized).foregroundStyle(.white))
                            .font(.applyPTSans(.bold, size: 16))
//                            .padding(.horizontal, 16)
                            .foregroundStyle(.white)
                            .frame(height: 50)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    
//                    Image(isPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .onTapGesture {
//                            isPasswordHidden.toggle()
//                        }
                        
                }
                .padding(.horizontal, 24)
                .background(
                    ZStack {
                        if password.wrappedValue.isEmpty == true {
                            RoundedRectangle(cornerRadius: 8).fill(Color.clear)
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder)
                        } else {
                            if loginData.wrappedValue?.status == "-1" {
                                RoundedRectangle(cornerRadius: 8).fill(Color.clear)
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorNegativeSecondary)
                            } else {
                                RoundedRectangle(cornerRadius: 8).fill(Color.colorPrimary.opacity(0.04))
                                RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorPrimary)
                            }
                        }
                    }
                )
                .frame(height: 50)
                .padding(.bottom, 8)

//                if loginData.wrappedValue?.status == "-1" {
//                    HStack {
//                        Image("ic_alert")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 15, height: 15)
//                        
//                        Text("incorrect_password".localized)
//                            .font(.apply(size: 12))
//                            .foregroundStyle(Color.colorNegativeSecondary)
//                    }
//                }

                HStack {
                    Button {
                        onForgotPasswordTap()
                    } label: {
                        Text("forget_your_password".localized)
                            .font(.applyPTSans(size: 18))
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
//            if !username.wrappedValue.isEmpty && !password.wrappedValue.isEmpty {
//                onSignInTap(username.wrappedValue, password.wrappedValue, isRememberMe.wrappedValue)
//            }
            onSignUpTap()
        }, label: {
            Text("login".localized)
                .font(.applyPTSans(.regular, size: 18))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray).opacity(0.5))
        })
        .padding(.horizontal, 165)
        .padding(.vertical, 16)
                
    }
    
    private var signUpView: some View {
        HStack {
            Text("no_account_yet".localized)
                .font(.applyPTSans(.regular, size: 16))
                .foregroundStyle(.white)
            Button {
                onSignUpTap()
            } label: {
                Text("join_us_now".localized)
                    .font(.applyPTSans(.regular, size: 16))
                    .foregroundStyle(.white)
            }

        }
    }
    
    private var videoTutorialView: some View {
        Button {
            onVideoTutorialTap()
        } label: {
            HStack {
                Image(systemName: "play.rectangle")
                    .resizable()
                    .frame(width: 18, height: 16)
                    .foregroundStyle(.gray)

                Text("video_tutorial".localized)
                    .font(.applyPTSans(.regular, size: 16))
                    .foregroundStyle(.white)

            }
            
        }

    }
}
