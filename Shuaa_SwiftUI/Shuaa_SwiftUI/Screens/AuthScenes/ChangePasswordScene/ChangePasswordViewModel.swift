//
//  ChangePasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import JavaScriptCore

class ChangePasswordViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private var useCase: LoginUseCaseProtocol
    
    @Published var nin: String?
    @Published var qID: String?
    @Published var username: String?
    
    @Published var listPasswordValidation: [PasswordValidationType:ChangePasswordUIModel] = [:]
    @Published var isAllPasswordMatch:Bool = false

    @Published var resetPasswordAdvanceAPIResult:APIResultType<ResetPasswordAdvanceUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: LoginUseCaseProtocol, nin: String, qID: String, username: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.username = username
        
        self.nin = nin
        self.qID = qID
        
        setPasswordValidationList()
    }
}


// MARK: Routing
extension ChangePasswordViewModel {
    func onBack() {
        coordinator.popViewController(animated: true)
    }
    
    func onConfirmChangePassword(password: String) {
        callResetPasswordAdvance(success: true, password: password)
    }
}

// MARK: API Calls
extension ChangePasswordViewModel {
    func callResetPasswordAdvance(success: Bool, password: String) {
        
        var newPassword = password
        var newUser = username

        let jsContext = JSContext()
              
        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encPass = (testFunction.call(withArguments: [newPassword])?.toString() ?? "")
                    newPassword = encPass
                    
                    let encUser = (testFunction.call(withArguments: [newUser])?.toString() ?? "")
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

        let requestModel = ResetPasswordAdvanceRequestModel(
            email: "",
            hdnKey: "",
            id: qID ?? "",
            mobile: "",
            mobileType: "iOS/unrecognized/17.3.1/v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")",
            nin: nin ?? "",
            newUser: "",
            oldPassword: "",
            password: newPassword,
            requestType: "",
            sessionID: "",
            tokenID: "",
            tradingNo: "",
            userIPAddress: "192.168.68.118",
            userName: newUser ?? "",
            webCode: "",
            lang: ""
        )
        
        resetPasswordAdvanceAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.ResetPasswordAdvance(requestModel: requestModel) {[weak self] result in
                
                self?.resetPasswordAdvanceAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    self?.resetPasswordAdvanceAPIResult = .onSuccess(response: success)
   
                    if success.status == "0" {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\("success".localized)")
                        self?.coordinator.popMultipleViews(count: 2, animated: true)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, AppUtility.shared.isRTL ? success.errorMsgAR ?? "" : success.errorMsg ?? "")
                    }
                    
                case .failure(let failure):
                    self?.resetPasswordAdvanceAPIResult = .onFailure(error: failure)
                        debugPrint("Failed to get user portfolio")
               
                }
            }
        }
    }

}

// MARK: Functions
extension ChangePasswordViewModel {
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
