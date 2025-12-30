//
//  VerifyOtpPopupViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import Combine
import JavaScriptCore

class ConfirmOtpPopupViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private var useCase: LoginUseCaseProtocol
    
    private var anyCancellable: AnyCancellable? = nil
    @Published var timerViewModel:OTPTimerViewModel
    @Published var otpExpirationTimer: Double = 60
    
    @Published var nin: String?
    @Published var qID: String?
    @Published var username: String?
    
    @Published var forgotType: ForgotDataEnum
    
    @Published var registrationsOTPAPIResult:APIResultType<RegistrationsOTPUIModel>?
    @Published var userAuthenticateAdvanceAPIResult:APIResultType<UserAuthenticationAdvanceUIModel>?

    init(coordinator: AuthCoordinatorProtocol, forgotType: ForgotDataEnum, useCase: LoginUseCaseProtocol, nin: String, qID: String, username: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.nin = nin
        self.qID = qID
        self.username = username
        
        self.forgotType = forgotType
        self.timerViewModel = .init()
        
        anyCancellable = timerViewModel.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
}

// MARK: Routing
extension ConfirmOtpPopupViewModel {
    func onDismiss() {
        coordinator.dismiss()
        
    }
    
    func onVerify(otp: String) {
        callRegistrationsOTPAPI(success: true, otp: otp)
    }
}

// MARK: API Calls
extension ConfirmOtpPopupViewModel {
    func callRegistrationsOTPAPI(success: Bool, otp: String) {
        
        var pin = otp
        var newUser = username

        let jsContext = JSContext()
              
        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encPin = (testFunction.call(withArguments: [otp])?.toString() ?? "")
                    pin = encPin
                    
                    let encUser = (testFunction.call(withArguments: [username])?.toString() ?? "")
                    newUser = encUser
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            print ("error")
        }

        let requestModel = RegistrationsOTPRequestModel(
            deviceID: "",
            emailAddress: "",
            fileName: "",
            fileType: "",
            fingerPrintID: "",
            fingerPrintLevel: "",
            guid: "",
            hdnKey: "",
            idNumber: "",
            mainClientId: "",
            mobileNo: "",
            mobileType: "iOS/unrecognized/17.3.1/v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")",
            newUser: "",
            oldPassword: "",
            password: "",
            password2: "",
            registrationId: "",
            sessionID: "",
            tokenID: pin,
            touchToken: "",
            tradingNo: "",
            uploadFile: [],
            userIPAddress: "192.168.68.118",
            userName: username,
            validityDate: "",
            versionNumber: "",
            webCode: "",
            isAuthorizeOnly: "Y",
            isIPOQuickSell: "N"
        )
        registrationsOTPAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.RegistrationsOTP(requestModel: requestModel) {[weak self] result, cookies in
                
                self?.registrationsOTPAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    self?.registrationsOTPAPIResult = .onSuccess(response: success)
   
                    if success.status == "0" {
                        KeyChainController().resetPasswordCookies = "\(cookies?.first?.name ?? "")=\(cookies?.first?.value ?? "")"

                        if self?.forgotType == .forgotPassword {
                            self?.coordinator.dismiss()
                            self?.coordinator.openChangePasswordScene(nin: self?.nin ?? "", qID: self?.qID ?? "", username: self?.username ?? "")
                        } else if self?.forgotType == .forgotPin {
                            self?.coordinator.dismiss()
                            self?.coordinator.openChangePinScene()
                        }
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.errorMsg ?? "")
                    }

                case .failure(let failure):
                    self?.registrationsOTPAPIResult = .onFailure(error: failure)
                        debugPrint("Failed to get user portfolio")
               
                }
            }
        }
    }
    
    func callUserAuthenticateAdvanceAPI(success: Bool) {

        let requestModel = UserAuthenticationAdvanceRequestModel(
            email: "",
            id: qID ?? "",
            mobile: "",
            mobileType: "iOS/unrecognized/17.3.1/v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")",
            nin: nin ?? "",
            requestType: "",
            userIPAddress: "192.168.68.118"
        )
        
        userAuthenticateAdvanceAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.userAuthenticationAdvance(requestModel: requestModel) {[weak self] result in
                
                self?.userAuthenticateAdvanceAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    self?.userAuthenticateAdvanceAPIResult = .onSuccess(response: success)
                    
                    debugPrint("Success to user authenticate advance")

                    if success.status == "0" {
                        self?.startTimer()
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.errorMsg ?? "")
                    }

                case .failure(let failure):
                    self?.userAuthenticateAdvanceAPIResult = .onFailure(error: failure)
                        debugPrint("Failed to get user portfolio")
               
                }
            }
        }
    }

}

// MARK: Functions
extension ConfirmOtpPopupViewModel {
    
}

// MARK: Timer
extension ConfirmOtpPopupViewModel {


    func initTimer() {
        timerViewModel.initTimer()
    }

    func startTimer() {
        timerViewModel.startTimer(resentOtpTimer: otpExpirationTimer)
    }

     func handleTimerValue(second: Int) {
         timerViewModel.handleTimerValue(second: second )

    }

    func endTimerIfNeed() {
        timerViewModel.endTimerIfNeed()
    }
}
