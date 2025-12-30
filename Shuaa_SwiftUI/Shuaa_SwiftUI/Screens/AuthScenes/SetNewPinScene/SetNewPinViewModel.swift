//
//  SetNewPinViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/10/2025.
//

import Foundation
import JavaScriptCore

class SetNewPinViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: LoginUseCaseProtocol
    
    @Published var username: String?
    @Published var password: String?
    
    @Published var LoginResponseModelAPIResult: APIResultType<LoginUIModel>?
    @Published var GetDeviceConfigsAPIResult: APIResultType<GetDeviceConfigsUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: LoginUseCaseProtocol, username: String, password: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.username = username
        self.password = password
    }
}

// MARK: Routing
extension SetNewPinViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func createNewPin(pin: String) {
        KeyChainController().userPin = pin
        callUsrAuthinticationByEmailAndMobileAPI()
    }
}

// MARK: API Calls
extension SetNewPinViewModel {
    func callUsrAuthinticationByEmailAndMobileAPI() {

        // MARK: - Save email & password in keychain
        KeyChainController().savedUsername = username
        KeyChainController().savedUserPassword = password
        
        var user = username
        var pass = password
 
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    if username != "" {
                      
                        var encUsername = (testFunction.call(withArguments: [username])?.toString() ?? "")

                        user = encUsername
                    }
                    
                    let encpassword = (testFunction.call(withArguments: [password])?.toString() ?? "")
                    
                    pass = encpassword
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
            password: pass ?? "",
            password2: "",
            registrationId: "dLy7NdV_7UPosCQkg0rZ5U:APA91bHV9cChNcmI6vIiPrlOO1eL0tH4VgCZ8Ob6A6QU0tsWnPhQb76hEVNkGJCr1y-6qiP36rWQeTpZDS0XQDUQ-LxybMJonZVZyvKMAoRIDa66_4eexYsKTVUQEL5X7yuEbi4f0cty",
            sessionID: "",
            tokenID: "",
            touchToken: "",
            tradingNo: "",
            userIPAddress: AppUtility.shared.getAddress(for: .wifi) ?? "",
            userName: user ?? "",
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
