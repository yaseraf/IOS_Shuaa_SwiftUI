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

    var body: some View {
        ZStack {
            
            Color.colorBG
                    .ignoresSafeArea()
                    .onTapGesture {
                        UIApplication.shared.dismissKeyboard()
                    }

            VStack {
                headerView
                    .padding(.top, 20)
//                    .padding(.bottom, 32)
                
                titleView
//                    .padding(.bottom, 24)
                
                inputFieldsView
                
                Spacer()
                
                signInView
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
            Image("ic_logo")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Button {
                onChangeLanguage()
            } label: {
                HStack {
                    Text("language".localized)
                        .font(.apply(size: 16))
                        .foregroundStyle(Color.colorTextPrimary)

                    
                    Image("ic_globe")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.colorTextPrimary)
                }
                .padding(.horizontal, 12)
                .frame(maxHeight: 36)
                .background(RoundedRectangle(cornerRadius: 78).stroke(lineWidth: 1).fill(Color.colorTextPrimary))
            }

        }
        .padding(.horizontal, 20)
    }
    
    private var titleView: some View {
        VStack(spacing: 8) {
            Text("hello_sign_in".localized)
                .font(.apply(.bold, size: 24))
                .foregroundStyle(Color.colorTextPrimary)

//            HStack {
//                Text("\("not_a_member_yet".localized)")
//                    .font(.apply(size: 16))
//                    .foregroundStyle(Color.gray)
//
//                Text("sign_up".localized)
//                    .font(.apply(size: 16))
//                    .foregroundStyle(Color.colorPrimary)
//                    .onTapGesture {
//                        debugPrint("tapped")
//                    }
//            }
        }
    }
    
    private var inputFieldsView: some View {
        var forgetNameAttribute: AttributedString {
            var str = AttributedString("forget_name".localized)
            str.underlineStyle = .single
            return str
        }
        var forgetPasswordAttribute: AttributedString {
            var str = AttributedString("forget_password".localized)
            str.underlineStyle = .single
            return str
        }
        return VStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text("user_name".localized)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

                TextField("please_enter_your_name".localized, text: username)
                    .font(.apply(size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
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
                    .padding(.bottom, 8)
                
                if loginData.wrappedValue?.status == "-1" {
                    HStack {
                        Image("ic_alert")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        
                        Text("wrong_user_name".localized)
                            .font(.apply(size: 12))
                            .foregroundStyle(Color.colorNegativeSecondary)
                    }
                }
                
//                HStack {
//                    Spacer()
//                    Text("\(forgetNameAttribute)")
//                        .font(.apply(size: 14))
//                        .foregroundStyle(Color.colorPrimary)
//                        .onTapGesture {
//                            onForgotNameTap()
//                        }
//                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("password".localized)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

                HStack {
                    if isPasswordHidden {
                        SecureField("password".localized, text: password)
                            .font(.apply(size: 14))
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField("password".localized, text: password)
                            .font(.apply(size: 14))
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Image(isPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            isPasswordHidden.toggle()
                        }
                        
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
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
                .padding(.bottom, 8)
                
                if loginData.wrappedValue?.status == "-1" {
                    HStack {
                        Image("ic_alert")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        
                        Text("incorrect_password".localized)
                            .font(.apply(size: 12))
                            .foregroundStyle(Color.colorNegativeSecondary)
                    }
                }

                HStack {
                    
                    Button {
                        onIsRememberMeTap()
                    } label: {
                        HStack(spacing: 8) {
                            Image(isRememberMe.wrappedValue ? "ic_checkbox" : "ic_checkboxEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .contentShape(Rectangle())

                            Text("remember_me".localized)
                                .font(.apply(size: 12))
                                .foregroundStyle(.gray)
                        }
                        .frame(maxHeight: 44)
                    }

                    Spacer()
                        
                    Button {
                        onForgotPasswordTap()
                    } label: {
                        Text("\(forgetPasswordAttribute)")
                            .font(.apply(size: 14))
                            .foregroundStyle(Color.colorPrimary)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var signInView: some View {
        Button(action: {
            if !username.wrappedValue.isEmpty && !password.wrappedValue.isEmpty {
                onSignInTap(username.wrappedValue, password.wrappedValue, isRememberMe.wrappedValue)
            }
        }, label: {
            Text("sign_in".localized)
                .font(.apply(.bold, size: 18))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(username.wrappedValue.isEmpty == false && password.wrappedValue.isEmpty == false ? 1 : 0.5))
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
        })
                
    }
}
