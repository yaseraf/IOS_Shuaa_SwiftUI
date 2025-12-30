//
//  LoginViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import JavaScriptCore
import CryptoKit
import LocalAuthentication

class LocalAuthenticationService {
    class func authenticateWithBiometrics(_ completion: @escaping (Result<Void, Error>) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    completion(.success(()))
                } else {
                    completion(.failure(error ?? NSError()))
                    //completion(.failure(AppError.error(error?.localizedDescription ?? "Error Undefined")))
//                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"Error evaluating biometrics policy".localized)
                    debugPrint("Error evaluating biometrics policy")
                }
            }
        } else {
            //completion(.failure(AppError.error("No Biometrics Available")))
            completion(.failure(error ?? NSError()))
            debugPrint("Error: No biometrics available")
        }
    }
}

class LoginViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private let useCase: LoginUseCaseProtocol
    
    @Published var username: String = ""
    @Published var password: String = ""

    @Published var isRememberMe: Bool = false
    @Published var showAlert: Bool = false
    
    @Published var loginData: LoginUIModel?
    
    @Published var showMessagePopUp:Bool = false
    @Published var loginMessage:String = ""
    
    @Published var LoginResponseModelAPIResult: APIResultType<LoginUIModel>?
    @Published var GetDeviceConfigsAPIResult: APIResultType<GetDeviceConfigsUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: LoginUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        isRememberMe = UserDefaultController().isRememberMe ?? false
        
        if isRememberMe {
            self.username = KeyChainController().savedUsername ?? ""
            self.password = KeyChainController().savedUserPassword ?? ""
        }
    }
}

// MARK: Routing
extension LoginViewModel {
    func openForgotPasswordScene() {
        coordinator.openForgotPasswordScene(forgotType: .forgotPassword)
    }
    
    func openForgotNameScene() {
        coordinator.openForgotPasswordScene(forgotType: .forgotName)
    }

    func openSetNewPinScene(username: String, password: String) {
        coordinator.openSetNewPinScene(username: username, password: password)
    }
    
    func openVerifyPinScene(username: String, password: String) {
        
//        var username1 = username
//        var password1 = password
//        
//        let jsContext = JSContext()
//
//        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
//            do {
//              
//                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
//                
//                jsContext!.evaluateScript(jsSourceContents)
//                
//                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
//                    if username != "" {
//                      
//                        var encUsername = (testFunction.call(withArguments: [username])?.toString() ?? "")
//
//                        username1 = encUsername
//                    }
//                    
//                    let encpassword = (testFunction.call(withArguments: [password1])?.toString() ?? "")
//                    
//                    password1 = encpassword
//                }
//            }
//            catch {
//                printToLog("JS error:\(error.localizedDescription)")
//            }
//        }
//        else {
//            debugPrint ("error")
//        }
        
        coordinator.openVerifyPinScene(username: username, password: password)
    }
}

// MARK: API Calls
extension LoginViewModel {
    func callUsrAuthinticationByEmailAndMobileAPI(username:String, password:String, isRememberMe:Bool, tokenID: String) {
        
        KeyChainController().username = username
        KeyChainController().password = password
        
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
            tokenID: tokenID,
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
                    
                    if success.userName?.lowercased() != KeyChainController().savedUsername?.lowercased() && KeyChainController().savedUsername?.isEmpty == false {
                        UserDefaultController().isRememberMe = false
                        self?.isRememberMe = false
                    }

                    
                    KeyChainController().authToken = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""
                    KeyChainController().loginCookieName = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? ""
                    KeyChainController().loginCookieValue = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""


                    self?.loginData = success
                    
                    if success.isFirstLogin?.lowercased() ?? "" == "y" {
                        KeyChainController().resetPasswordCookies = "\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? "")=\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? "")"
                        KeyChainController().username = success.userName ?? ""
                        KeyChainController().webCode = success.webCode ?? ""
                        UserDefaultController().isFirstLogin = true

//                      self?.openResetPasswordScene(cookies: cookies)
                    }
                    
                    UserDefaultController().selectedUserAccount = nil
                    
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
                    
//                    UserDefaultController().iconPath = success.iconPath
                    UserDefaultController().iconPath = "https://www.qe.com.qa/pps/companylogos/"
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
extension LoginViewModel {    
    func faceId(username: String, password : String, isRememberMe: Bool){
        LocalAuthenticationService.authenticateWithBiometrics { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    UserDefaultController().isBiometricEnabled = true
                    self.showAlert = false
                    self.GetDeviceConfigs(success: true)
                    KeyChainController().savedUsername = username
                    KeyChainController().savedUserPassword = password
                    UserDefaultController().isRememberMe = true
                    SceneDelegate.getAppCoordinator()?.showHomeFlow()
                }
            case .failure(let error):
                debugPrint("")
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"Error: No biometrics available".localized)
                self.isRememberMe = false
                UserDefaultController().isRememberMe = false
            }
        }
    }
    
    func onIsRememberMeTap() {
        isRememberMe.toggle()
    }
    
    func changeLanguage() {
        AppUtility.shared.updateAppLanguage(language: AppUtility.shared.isRTL ? .english : .arabic)
        SceneDelegate.getAppCoordinator()?.restart()
    }
}
