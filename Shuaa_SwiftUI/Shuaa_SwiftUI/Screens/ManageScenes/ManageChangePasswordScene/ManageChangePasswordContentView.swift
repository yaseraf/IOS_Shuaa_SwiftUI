//
//  ChangePasswordContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI 

struct ManageChangePasswordContentView: View {
    enum FocusPassword {
        case  newPassword, confirmPassword
    }

    var listPasswordValidation: Binding<[PasswordValidationType:ChangePasswordUIModel]>
    var isAllPasswordMatch:Binding<Bool>

    @FocusState private var pinFocusState : FocusPassword?

    @State var oldPassword = ""
    @State var newPassword = ""
    @State var confirmNewPassword = ""
    
    @State var isOldPasswordHidden = true
    @State var isNewPasswordHidden = true
    @State var isConfirmNewPasswordHidden = true
    
    @State var isConfirmPasswordMatching = true
    
    var onBack:()->Void
    var onConfirmChangePassword:(String, String)->Void
    var onPasswordChange:(String) -> Void

    var body: some View {
        VStack {
            
            Spacer().frame(height: 20)
            
            headerView
            
            Spacer().frame(height: 20)

            inputFieldsView
            
            Spacer()
            
            confirmButtonView
            
            Spacer().frame(height: 20)
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "#EDEEF6"))
                .overlay {
                    Image("ic_back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .scaleEffect(AppUtility.shared.isRTL ? -1 : 1)
                }
                .onTapGesture {
                    onBack()
                }
            
            Spacer()
            
            Text("change_password".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            Circle()
                .frame(width: 40, height: 40)
                .opacity(0)
            
        }
    }
    
    private var inputFieldsView: some View {
        VStack(alignment: .leading) {
            Text("old_password".localized)
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            HStack {
                if isOldPasswordHidden {
                    SecureField("old_password".localized, text: $oldPassword)
                        .font(.apply(size: 14))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)

                } else {
                    TextField("old_password".localized, text: $oldPassword)
                        .font(.apply(size: 14))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)

                }
                
                Image(isOldPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isOldPasswordHidden.toggle()
                    }
                
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
            .padding(.bottom, 8)
            
            Text("new_password".localized)
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            HStack {
                if isNewPasswordHidden {
                    SecureField("new_password".localized, text: $newPassword)
                        .font(.apply(size: 14))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .focused($pinFocusState, equals: .newPassword)
                        .onChange(of: newPassword) { val in
                            onPasswordChange(val)
                        }

                } else {
                    TextField("new_password".localized, text: $newPassword)
                        .font(.apply(size: 14))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .focused($pinFocusState, equals: .newPassword)
                        .onChange(of: newPassword) { val in
                            onPasswordChange(val)
                        }

                }
                
                Image(isNewPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isNewPasswordHidden.toggle()
                    }
                
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
            .padding(.bottom, 8)
            
            if pinFocusState == .newPassword || isAllPasswordMatch.wrappedValue == false {
                Spacer().frame(height: 12)
                getPasswordListView()
            }
            
            Text("confirm_new_password".localized)
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            HStack {
                if isConfirmNewPasswordHidden {
                    SecureField("confirm_new_password".localized, text: $confirmNewPassword)
                        .font(.apply(size: 14))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: confirmNewPassword) { newVal in
                            if confirmNewPassword == newPassword {
                                isConfirmPasswordMatching = true
                            } else {
                                isConfirmPasswordMatching = false
                            }
                        }
                        .focused($pinFocusState, equals: .confirmPassword)

                } else {
                    TextField("confirm_new_password".localized, text: $confirmNewPassword)
                        .font(.apply(size: 14))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: confirmNewPassword) { newVal in
                            if confirmNewPassword == newPassword {
                                isConfirmPasswordMatching = true
                            } else {
                                isConfirmPasswordMatching = false
                            }
                        }
                        .focused($pinFocusState, equals: .confirmPassword)
                }
                
                Image(isConfirmNewPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isConfirmNewPasswordHidden.toggle()
                    }
                
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(isConfirmPasswordMatching ? Color.colorBorder : Color.colorAlert))
            .padding(.bottom, 8)
            
            if !isConfirmPasswordMatching {
                HStack {
                    Image("ic_alert")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text("confirm_password_is_not_matching".localized)
                        .font(.apply(size: 14))
                        .foregroundStyle(Color.colorAlert)
                }
//                .padding(.horizontal, 16)

            }
        }
    }
    
    private var confirmButtonView: some View {
        Button {
            onConfirmChangePassword(oldPassword, confirmNewPassword)
        } label: {
            Text("change_password".localized)
                .font(.apply(.bold, size: 18))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(checkEnableBtn() ? 1 : 0.5))
                .padding(.horizontal, 20)
        }
        .disabled(!checkEnableBtn())
    }
    
    private func getPasswordListView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("your_password_must_include".localized)
                    .font(Font.apply(.semiBold,size: 13))
                    .foregroundColor(.colorTextPrimary)

                Spacer()

                if !getPasswordStrong().0.isEmpty{
                        Text(getPasswordStrong().0)
                            .font(Font.apply(.semiBold,size: 13))
                            .foregroundColor(getPasswordStrong().1)


                }

            }
            
            ForEach(Array(listPasswordValidation.wrappedValue.keys.sorted(by: {$0.index < $1.index})), id: \.self) { key in

                HStack {
                    passwordItemView(key: key, value: listPasswordValidation.wrappedValue[key] ?? .init(match: .none))
                }

            }

        }
            .padding(.vertical,16)
            .padding(.horizontal,20)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.colorBGTertiary))
    }
    
    private func getPasswordStrong() ->(String,Color) {
        let count = Array(listPasswordValidation.wrappedValue.values).filter({
            $0.match == .success
        }).count
        if count == 0 && newPassword.isEmpty{
            return ("",.clear)
        }else if count < listPasswordValidation.wrappedValue.count && !newPassword.isEmpty{
            return ("weak".localized,.colorError)
        }
        else{
            return ("strong".localized,.colorSuccess2)

        }
    }
    
    private func passwordItemView(key:PasswordValidationType,value:ChangePasswordUIModel) -> some View {
        HStack(alignment: .center,spacing: 0){
          Image(value.match == .success ? "ic_checkCircleSelected" : "ic_checkCircle")
              .resizable()
              .frame(width: 18)
              .frame(height: 18)
          Spacer().frame(width: 8)
          Text(key.message)
              .font(Font.apply(.medium,size: 13))
              .foregroundColor(.colorTextSecondaryThird)
        }
    }
    
    private func checkEnableBtn() -> Bool {
        return !newPassword.isEmpty && confirmNewPassword == newPassword && isAllPasswordMatch.wrappedValue == true
    }

}

