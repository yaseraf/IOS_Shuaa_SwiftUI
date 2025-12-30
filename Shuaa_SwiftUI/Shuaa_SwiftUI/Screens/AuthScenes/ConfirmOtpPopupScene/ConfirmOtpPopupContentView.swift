//
//  VerifyOtpPopupContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import SwiftUI

struct ConfirmOtpPopupContentView: View {
    enum FocusPin {
        case pinOne
        case pinTwo
        case pinThree
        case pinFour
        case pinFive
//        case pinSix
    }
    
    var timerObserve:Binding<(Int, String)?>

    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne:String = ""
    @State var pinTwo:String = ""
    @State var pinThree:String = ""
    @State var pinFour:String = ""
    @State var pinFive:String = ""
//    @State var pinSix:String = ""
    
    @State var hasAutoFilled: Bool = false

    var onDismiss:() -> Void
    var onResendOtpTap:()->Void
    var onVerify:(String) -> Void
    
    private func calculateOTPValue() {
//        let string = ("\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)\(pinSix)")
        let string = ("\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)")
//        onVerify(string)
    }
    
    private func fillAllFields(with otp: String) {
        let otpArray = Array(otp.prefix(5)) // Ensure only 6 digits
        if otpArray.count == 5 {
            pinOne = String(otpArray[0])
            pinTwo = String(otpArray[1])
            pinThree = String(otpArray[2])
            pinFour = String(otpArray[3])
            pinFive = String(otpArray[4])
//            pinSix = String(otpArray[5])
            hasAutoFilled = true
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
                        
            headerView
            
            Spacer().frame(height: 20)

            pinsView
            
            Spacer().frame(height: 20)
            
            forgetOtpView
            
            Spacer().frame(height: 20)
            
            verifyButton
            
            Spacer()

        }
        .padding(.bottom,AppUtility.bottomNotch)
        .padding(.top,16)
        .background(Color.colorBG)
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .onAppear {
            hasAutoFilled = false
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .frame(height: 4)
                .padding(.horizontal, 165)
                .padding(.bottom, 8)
                .foregroundStyle(Color.colorBorder)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("otp".localized)
                    .font(.apply(.medium, size: 16))
                    .foregroundColor(Color.colorTextPrimary)

                    
                Spacer()
                
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 24)
                    )
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 36)
            
            Text("please_enter_your_otp_to_confirm".localized)
                .font(.apply(.regular, size: 16))
        }
    }
    
    private var pinsView: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinOne)
                        .modifier(OtpModifer(pin: $pinOne))
                        .onChange(of: pinOne) { newVal in
                            if newVal.count > 1 {
                                fillAllFields(with: newVal)
                        
                            } else if checkNextValue(newVal: newVal) {
                                if hasAutoFilled {
                                    pinFocusState = .pinFive
                                    hideKeyboard()
                                } else {
                                    pinFocusState = .pinTwo
                                }
                            }
                            calculateOTPValue()
                        }
                        .focused($pinFocusState, equals: .pinOne)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinTwo)
                        .modifier(OtpModifer(pin: $pinTwo))
                        .onChange(of:pinTwo){newVal in
                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinThree
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinOne
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinTwo)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinThree)
                        .modifier(OtpModifer(pin: $pinThree))
                        .onChange(of:pinThree){newVal in
                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinFour
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinTwo
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinThree)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinFour)
                        .modifier(OtpModifer(pin: $pinFour))
                        .onChange(of:pinFour){newVal in

                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinFive
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinThree
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinFour)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinFive)
                        .modifier(OtpModifer(pin: $pinFive))
                        .onChange(of:pinFive){newVal in
//                            if (checkNextValue(newVal: newVal)) {
//                                pinFocusState = .pinSix
//                            }else {
//                                if (checkPrevValue(newVal: newVal)) {
//                                    pinFocusState = .pinFour
//                                }
//                            }
//                            calculateOTPValue()

                            if (checkPrevValue(newVal: newVal)) {
                                pinFocusState = .pinFour
                            }else{
                                hideKeyboard()

                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinFive)
                        .textContentType(.oneTimeCode)
                }
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(lineWidth: 1)
//                .foregroundStyle(Color.colorBorder)
//                .frame(height: 56)
//                .overlay {
//                    TextField("-", text: $pinSix)
//                        .modifier(OtpModifer(pin: $pinSix))
//                        .onChange(of:pinSix){newVal in
//                            if (checkPrevValue(newVal: newVal)) {
//                                pinFocusState = .pinFive
//                            }else{
//                                hideKeyboard()
//
//                            }
//                            calculateOTPValue()
//                        }
//                        .focused($pinFocusState, equals: .pinSix)
//                        .textContentType(.oneTimeCode)
//                }
        }
        .padding(.horizontal, 20)
    }
    
    private var forgetOtpView: some View {
        let timeInt =   timerObserve.wrappedValue?.0 ?? 0

        return HStack{
            if timeInt <= 0 {
                Button {
                    onResendOtpTap()
                } label: {
                    Text("resend_otp".localized)
                        .font(.apply(size: 14))
                        .foregroundStyle(Color.colorPrimary)
                }
            } else if timeInt > 0 {
                Text(AppUtility.shared.isRTL ? "\("seconds".localized) \(timerObserve.wrappedValue?.1 ?? "") " : "\(timerObserve.wrappedValue?.1 ?? "") \("seconds".localized)")
                    .font(.apply(size: 14))
                    .foregroundStyle(Color.colorPrimary)
            }
        }
        
    }
    
    private var verifyButton: some View {
        Button {
//            onVerify("\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)\(pinSix)")
            onVerify("\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)")
        } label: {
            Text("verify".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.white)
                .frame(maxHeight: 48)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
                .padding(.horizontal, 24)
        }
    }
    
    private func checkNextValue(newVal:String) ->Bool{
        return newVal.count == 1
    }

    private func checkPrevValue(newVal:String) ->Bool{
        return newVal.count == 0
    }
}
