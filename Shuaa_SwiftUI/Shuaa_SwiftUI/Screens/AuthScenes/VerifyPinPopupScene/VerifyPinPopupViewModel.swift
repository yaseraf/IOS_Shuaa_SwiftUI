//
//  VerifyOtpPopupViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import UIKit
import JavaScriptCore

class VerifyPinPopupViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private let useCase: LoginUseCase
    
    @Published var username:String?
    @Published var password:String?
    
    @Published var otpAPIResult: APIResultType<otpUIModel>?
    @Published var GetDeviceConfigsAPIResult: APIResultType<GetDeviceConfigsUIModel>?
    @Published var LoginResponseModelAPIResult: APIResultType<LoginUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: LoginUseCase, username: String, password: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        self.username = username
        self.password = password
    }
}

// MARK: Routing
extension VerifyPinPopupViewModel {
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func openForgotPinScene() {
        coordinator.dismiss()
        coordinator.openForgotPasswordScene(forgotType: .forgotPin)
    }
}

// MARK: API Calls
extension VerifyPinPopupViewModel {
    func callUsrAuthinticationByEmailAndMobileAPI(username:String, password:String, isRememberMe:Bool) {
        
        var username = username
        var password1 = password
 
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    if username != "" {
                      
                        var encUsername = (testFunction.call(withArguments: [username])?.toString() ?? "")

                        username = encUsername
                    }
                    
                    let encpassword = (testFunction.call(withArguments: [password1])?.toString() ?? "")
                    
                    password1 = encpassword
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            debugPrint ("error")
        }
        
        let loginRequest = LoginRequestModel(
            emailAddress: "",
            hdnKey: "",
            fingerPrintId: "",
            mainClientID: "",
            mobileNo: "",
            mobileType: "iOS/unrecognized/17.3.1/V.1",
            newUser: "",
            oldPassword: "",
            password: password1,
            password2: "",
            registrationId: "dLy7NdV_7UPosCQkg0rZ5U:APA91bHV9cChNcmI6vIiPrlOO1eL0tH4VgCZ8Ob6A6QU0tsWnPhQb76hEVNkGJCr1y-6qiP36rWQeTpZDS0XQDUQ-LxybMJonZVZyvKMAoRIDa66_4eexYsKTVUQEL5X7yuEbi4f0cty",
            sessionID: "",
            tokenID: "",
            touchToken: "",
            tradingNo: "",
            userIPAddress: AppUtility.shared.getAddress(for: .wifi) ?? "",
            userName: username,
            versionNumber: "1",
            webCode: "",
            isAuthorizeOnly: "N"
        )
                       
        LoginResponseModelAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.loginMap(requestModel: loginRequest) {[weak self] result, cookies in
                self?.LoginResponseModelAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    KeyChainController().authToken = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""
                    KeyChainController().loginCookieName = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? ""
                    KeyChainController().loginCookieValue = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""


//                    self?.loginData = success
                    
                    if success.isFirstLogin?.lowercased() ?? "" == "y" {
                        KeyChainController().resetPasswordCookies = "\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? "")=\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? "")"
                        KeyChainController().username = success.userName ?? ""
                        KeyChainController().webCode = success.webCode ?? ""
                        UserDefaultController().isFirstLogin = true

//                      self?.openResetPasswordScene(cookies: cookies)
                    }
                    
                    self?.LoginResponseModelAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.LoginResponseModelAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    func GetDeviceConfigs(success:Bool) {
        let requestModel = GetDeviceConfigsRequestModel()
        GetDeviceConfigsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetDeviceConfigs(requestModel: requestModel) {[weak self] result in
                self?.GetDeviceConfigsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.GetDeviceConfigsAPIResult = .onSuccess(response: success)
                    
                    UserDefaultController().iconPath = success.iconPath
                    UserDefaultController().BackgroundWatchList = success.BackgroundWatchList
                    UserDefaultController().sessiontimeoutPerSec = success.sessiontimeoutPerSec

                case .failure(let failure):
                    self?.GetDeviceConfigsAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
}

// MARK: Functions
extension VerifyPinPopupViewModel {
    func onVerify(tokenId: String) {
        callUsrAuthinticationByEmailAndMobileAPI(username: username ?? "", password: password ?? "", isRememberMe: UserDefaultController().isRememberMe ?? false)
    }
}
