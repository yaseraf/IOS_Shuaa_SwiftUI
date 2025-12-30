//
//  ChangePasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import JavaScriptCore

class ManageChangePasswordViewModel: ObservableObject {
    private var coordinator: ManageCoordinatorProtocol
    private var useCase: HomeUseCaseProtocol
    
    @Published var listPasswordValidation: [PasswordValidationType:ChangePasswordUIModel] = [:]
    @Published var isAllPasswordMatch:Bool = false

    @Published var changesPasswordAPIResult:APIResultType<ChangesPasswordUIModel>?

    init(coordinator: ManageCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        setPasswordValidationList()
    }
    
}

// MARK: Routing
extension ManageChangePasswordViewModel {
    func onBack() {
        coordinator.popViewController(animated: true)
    }
    
    func onConfirmChangePassword(oldPassword: String, password: String) {
        callChangesPasswordAPI(success: true, oldPassword: oldPassword, password: password)
    }
}

// MARK: API Calls
extension ManageChangePasswordViewModel {
    func callChangesPasswordAPI(success: Bool, oldPassword: String, password: String) {
        
        // According to ETrade
        // username not encrypted
        // oldPassword not encrypted
        // newPassword encrypted
        // Webcode not encrypted
        // Password2 encrypted
        
        var newPassword = password
        var newUser = KeyChainController().username ?? ""

        let jsContext = JSContext()
              
        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encPass = (testFunction.call(withArguments: [newPassword])?.toString() ?? "")
                    newPassword = encPass
                    
//                    let encUser = (testFunction.call(withArguments: [newUser])?.toString() ?? "")
//                    newUser = encUser
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            print ("error")
        }

        let requestModel = ChangesPasswordRequestModel(
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
            mobileType: "",
            newUser: "",
            oldPassword: oldPassword,
            password: newPassword,
            password2: "",
            registrationId: "",
            sessionID: "",
            tokenID: "",
            touchToken: "",
            tradingNo: "",
            uploadFile: [],
            userIPAddress: "192.168.68.118",
            userName: KeyChainController().username ?? "",
            validityDate: "",
            versionNumber: "",
            webCode: KeyChainController().webCode ?? "",
            isAuthorizeOnly: "N",
            isIPOQuickSell: ""
        )
        
        changesPasswordAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.ChangesPassword(requestModel: requestModel) {[weak self] result in
                
                self?.changesPasswordAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    self?.changesPasswordAPIResult = .onSuccess(response: success)
   
                    if success.status == "0" {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\("success".localized)")
                        self?.coordinator.popViewController()
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, AppUtility.shared.isRTL ? success.errorMsgAR ?? "" : success.errorMsg ?? "")
                    }
                    
                case .failure(let failure):
                    self?.changesPasswordAPIResult = .onFailure(error: failure)
                        debugPrint("Failed to get user portfolio")
               
                }
            }
        }
    }
}

// MARK: Functions
extension ManageChangePasswordViewModel {
    private func setPasswordValidationList(){
         var listPasswordValidation : [PasswordValidationType:ChangePasswordUIModel] = [:]
         listPasswordValidation[.eightDigitCount] = .init( match: .none)
         listPasswordValidation[.atLeastOneNumber] = .init( match: .none)
         listPasswordValidation[.atLeastOneChar] = .init( match: .none)
         listPasswordValidation[.atLeastOneSpecialCharacter] = .init( match: .none)
         listPasswordValidation[.atLeastOneCapitalLetter] = .init( match: .none)

         self.listPasswordValidation = listPasswordValidation
     }
    
    func checkValidation(text:String) {
        let hasNumber = text.rangeOfCharacter(from: .decimalDigits) != nil
        let hasCharacter = text.rangeOfCharacter(from: .letters) != nil
        let specialCharacterCheck = text.rangeOfCharacter(from: .alphanumerics.inverted) != nil
        let capitalLetterCheck = text.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasMinimumLength = text.count >= 8

        listPasswordValidation[.eightDigitCount] = .init( match: text.isEmpty ? .none : (hasMinimumLength ? .success : .failed))
        listPasswordValidation[.atLeastOneNumber] = .init( match: text.isEmpty ? .none : (hasNumber ? .success : .failed))
        listPasswordValidation[.atLeastOneChar] = .init( match: text.isEmpty ? .none : (hasCharacter ? .success : .failed))
        listPasswordValidation[.atLeastOneSpecialCharacter] = .init( match: text.isEmpty ? .none : (specialCharacterCheck ? .success : .failed))
        listPasswordValidation[.atLeastOneCapitalLetter] = .init( match: text.isEmpty ? .none : (capitalLetterCheck ? .success : .failed))
    }

    func checkIsAllPasswordMatch() {
        let count = Array(listPasswordValidation.values).filter({
            $0.match == .success
        }).count

        isAllPasswordMatch = count == listPasswordValidation.count
    }
}
