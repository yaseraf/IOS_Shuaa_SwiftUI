//
//  SplashScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import SwiftUI
import Combine

struct SplashScene: View {
     @ObservedObject  private var viewModel: SplashViewModel

    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SplashContentView()
                    .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        viewModel.openLoginScene()
//                        viewModel.callUsrAuthinticationByEmailAndMobileAPI(username: "demo", password: "DEMO", isRememberMe: false, tokenID: "")
                    }
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            loginAPI()
        }
    }

    private func loginAPI() {
        viewModel.$LoginResponseModelAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let data):
                var isAllGood = true
                var msg = ""
                
                let status = Int(data.status ?? "") ?? 0
                if(!(data.errorMsg ?? "").isEmpty) {
                    isAllGood = false
                    msg = (data.errorMsg ?? "")
                }
                else if status < 0 {
                    isAllGood = false
                    
                    if(status == loginState.invalidLogin) {
                        msg = "Invalid_Username_password".localized // "Status = -1, invalidLogin"
                    }
                    else if(status == loginState.invalidTokenID) {
                        msg =  "Invalid_Token_ID".localized  // "Status = -2, invalidTokenID"
                    }
                    else if(status == loginState.tokenSent) {
                        msg = "Please_enter_Token".localized // "Status = -3, tokenSent"
                    }
                    else if(status == loginState.tokenExpire) {
                        msg = "Token_Expired".localized // "Status = -4, tokenExpire"
                    }
                    else if(status == loginState.noPermetions) {
                        msg = "No_permissions".localized // "Status = -5, noPermetions"
                    }
                    else if(status == loginState.userLocked) {
                        msg = "User_Locked".localized // "Status = -6, userLocked"
                    }
                    else if(status == loginState.anotherUserLogin) {
                        msg = "userAlreadyLoggedIn".localized // "Status = -7, anotherUserLogin"
//                        viewModel.showMessagePopUp = true
//                        viewModel.loginMessage = "userAlreadyLoggedIn".localized
                    }
                    else if(status == loginState.userNotAgreeTermCondtion) {
                        msg = "not_agreed_terms_conditions".localized // "Status = -8, userNotAgreeTermCondtion"
                    }
                    else if(status == loginState.unknowError) {
                        msg = "Status = -10, unknowError"
                    }
                    else if((data.webCode ?? "").elementsEqual("-1")) {
                        msg = "webCode = -1"
                    }
                    else {
                        msg = "Status = " + String(status)
                    }
                }
                else if((data.webCode ?? "").elementsEqual("-1")) {
                    isAllGood = false
                    msg = "WebCode = -1"
                }
                else if((data.webCode ?? "").isEmpty) {
                    isAllGood = false // true false
                    msg = "WebCode is Empty"
                }
                                  
                if status == -3  {

                    
                    KeyChainController().username = data.userName ?? ""
                    KeyChainController().webCode = data.webCode ?? ""
                    KeyChainController().brokerID = data.brokerID ?? ""
                    KeyChainController().UCODE = data.uCode ?? ""
                    KeyChainController().userType = data.userType ?? ""
                    KeyChainController().compInit = data.compInit ?? ""
                    
                    if data.isFirstLogin?.lowercased() ?? "" == "y" {

                    } else if data.isFirstLogin?.lowercased() ?? "" == "n" {
//                        viewModel.openVerifyOtpScene(username: KeyChainController().savedUserEmail ?? "", password: KeyChainController().savedUserPassword ?? "")
                    }
                }
                else if !isAllGood {
                    
                      if ((msg == "WebCode = -1") || (msg == "WebCode is Empty"))  {
                          msg = NSLocalizedString("request_rejected", comment: "")
                      }

                      let newMsg = "success \(String(describing: Date().toString(dateFormat: .MMMdd_yyyy)))"
                      SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,msg)
                    
                } else if isAllGood {
                    
                    KeyChainController().username = data.userName ?? ""
                    KeyChainController().webCode = data.webCode ?? ""
                    KeyChainController().brokerID = data.brokerID ?? ""
                    KeyChainController().UCODE = data.uCode ?? ""
                    KeyChainController().userType = data.userType ?? ""
                    KeyChainController().compInit = data.compInit ?? ""
                    UserDefaultController().isPreviewMode = false

                    
//                    if viewModel.isRememberMe {
//                        if UserDefaultController().isRememberMe == true {
//                            if UserDefaultController().isBiometricEnabled == true {
//                                viewModel.faceId(username: KeyChainController().username ?? "", password: KeyChainController().password ?? "", isRememberMe: true)
//                            } else {
//                                viewModel.openVerifyPinScene(username: KeyChainController().username ?? "", password: KeyChainController().password ?? "")
//                            }
//                        } else {
//                            viewModel.showAlert = true
//                        }
//                    } else {
//                        UserDefaultController().isRememberMe = false
//                        UserDefaultController().isBiometricEnabled = false
//                        UserDefaultController().isPinEnabled = false
//                        KeyChainController().userPin = ""
//                        KeyChainController().savedUsername = ""
//                        KeyChainController().savedUserPassword = ""
//                        viewModel.GetDeviceConfigs(success: true)
//                        SceneDelegate.getAppCoordinator()?.showHomeFlow()
//                    }
                    
                    UserDefaultController().isRememberMe = false
                    UserDefaultController().isBiometricEnabled = false
                    UserDefaultController().isPinEnabled = false
                    KeyChainController().userPin = ""
                    KeyChainController().savedUsername = ""
                    KeyChainController().savedUserPassword = ""
                    viewModel.GetDeviceConfigs(success: true)
                    UserDefaultController().isPreviewMode = true
                    SceneDelegate.getAppCoordinator()?.showHomeFlow()

                }

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }

}
