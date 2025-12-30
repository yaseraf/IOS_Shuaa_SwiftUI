//
//  SetNewPinContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/10/2025.
//

import Foundation
import SwiftUI

struct SetNewPinContentView: View {
    
    enum FocusPin {
        case pinOne
        case pinTwo
        case pinThree
        case pinFour
    }
    
    enum ConfirmFocusPin {
        case confirmPinOne
        case confirmPinTwo
        case confirmPinThree
        case confirmPinFour
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @FocusState private var confirmPinFocusState : ConfirmFocusPin?
    
    @State private var pinOne:String = ""
    @State private var pinTwo:String = ""
    @State private var pinThree:String = ""
    @State private var pinFour:String = ""
    
    @State private var confirmPinOne:String = ""
    @State private var confirmPinTwo:String = ""
    @State private var confirmPinThree:String = ""
    @State private var confirmPinFour:String = ""
    
    @State private var arePinsMatching: Bool = true
    
    var onCreatePinTap:(String) -> Void
    var onBack:()->Void
    
    var body: some View {
        VStack {
            headerView
            
            pinsView
            
            confirmPinsView
            
            Spacer()
            
            createPinButton
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
            
            Text("set_pin".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            Circle()
                .frame(width: 40, height: 40)
                .opacity(0)
            
        }
    }

    private var pinsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("new_pin".localized)
                .font(.apply(.medium, size: 14))
                .foregroundStyle(Color.colorTextPrimary)

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
                            
                                } else if checkNextValue(newVal: newVal) {
                                    pinFocusState = .pinTwo
                                }
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
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinThree
                                }else{
                                    hideKeyboard()
                                }
                            }
                            .focused($pinFocusState, equals: .pinFour)
                            .textContentType(.oneTimeCode)
                    }
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinFour)
                            .modifier(OtpModifer(pin: $confirmPinFour))
                            .onChange(of:confirmPinFour){newVal in
                                if (checkPrevValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinThree
                                }else{
                                    hideKeyboard()
                                    checkPinsMatching()
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinFour)
                            .textContentType(.oneTimeCode)
                    }
                    .disabled(false)
                    .opacity(0)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinFour)
                            .modifier(OtpModifer(pin: $confirmPinFour))
                            .onChange(of:confirmPinFour){newVal in
                                if (checkPrevValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinThree
                                }else{
                                    hideKeyboard()
                                    checkPinsMatching()
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinFour)
                            .textContentType(.oneTimeCode)
                    }
                    .disabled(false)
                    .opacity(0)


            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)

    }
    
    private var confirmPinsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("confirm_new_pin".localized)
                .font(.apply(.medium, size: 14))
                .foregroundStyle(Color.colorTextPrimary)

            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinOne)
                            .modifier(OtpModifer(pin: $confirmPinOne))
                            .onChange(of: confirmPinOne) { newVal in
                                if newVal.count > 1 {
                            
                                } else if checkNextValue(newVal: newVal) {
                                    confirmPinFocusState = .confirmPinTwo
                                    checkPinsMatching()
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinOne)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinTwo)
                            .modifier(OtpModifer(pin: $confirmPinTwo))
                            .onChange(of:confirmPinTwo){newVal in
                                if (checkNextValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinThree
                                    checkPinsMatching()
                                }else {
                                    if (checkPrevValue(newVal: newVal)) {
                                        confirmPinFocusState = .confirmPinOne
                                    }
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinTwo)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinThree)
                            .modifier(OtpModifer(pin: $confirmPinThree))
                            .onChange(of:confirmPinThree){newVal in
                                if (checkNextValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinFour
                                    checkPinsMatching()
                                }else {
                                    if (checkPrevValue(newVal: newVal)) {
                                        confirmPinFocusState = .confirmPinTwo
                                    }
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinThree)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinFour)
                            .modifier(OtpModifer(pin: $confirmPinFour))
                            .onChange(of:confirmPinFour){newVal in
                                if (checkPrevValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinThree
                                }else{
                                    hideKeyboard()
                                    checkPinsMatching()
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinFour)
                            .textContentType(.oneTimeCode)
                    }

                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinFour)
                            .modifier(OtpModifer(pin: $confirmPinFour))
                            .onChange(of:confirmPinFour){newVal in
                                if (checkPrevValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinThree
                                }else{
                                    hideKeyboard()
                                    checkPinsMatching()
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinFour)
                            .textContentType(.oneTimeCode)
                    }
                    .disabled(false)
                    .opacity(0)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmPinFour)
                            .modifier(OtpModifer(pin: $confirmPinFour))
                            .onChange(of:confirmPinFour){newVal in
                                if (checkPrevValue(newVal: newVal)) {
                                    confirmPinFocusState = .confirmPinThree
                                }else{
                                    hideKeyboard()
                                    checkPinsMatching()
                                }
                            }
                            .focused($confirmPinFocusState, equals: .confirmPinFour)
                            .textContentType(.oneTimeCode)
                    }
                    .disabled(false)
                    .opacity(0)

            }
            
            if arePinsMatching == false {
                HStack {
                    Image("ic_error")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    
                    Text("incorrect_pin".localized)
                        .font(.apply(size: 14))
                        .foregroundStyle(Color.colorAlert)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)

    }

    
    private var createPinButton: some View {
        Button {
            onCreatePinTap("\(pinOne)\(pinTwo)\(pinThree)\(pinFour)")
        } label: {
            Text("create_pin".localized)
                .font(.apply(.medium, size: 18))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(enabledBtn() ? 1 : 0.5))
                .padding(.horizontal, 20)
        }
        .disabled(!enabledBtn())
    }
    
    private func enabledBtn() -> Bool {
        return !pinOne.isEmpty && !pinTwo.isEmpty && !pinThree.isEmpty && !pinFour.isEmpty && (pinOne == confirmPinOne) && (pinTwo == confirmPinTwo) && (pinThree == confirmPinThree) && (pinFour == confirmPinFour) && arePinsMatching
    }
    
    private func checkPinsMatching() {
        if (pinOne == confirmPinOne) && (pinTwo == confirmPinTwo) && (pinThree == confirmPinThree) && (pinFour == confirmPinFour) {
            arePinsMatching = true
        } else {
            arePinsMatching = false
        }
    }
    
    private func checkNextValue(newVal:String) ->Bool{
        return newVal.count == 1
    }

    private func checkPrevValue(newVal:String) ->Bool{
        return newVal.count == 0
    }
}
