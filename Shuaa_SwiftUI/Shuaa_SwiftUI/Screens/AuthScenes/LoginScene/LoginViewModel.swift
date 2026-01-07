//
//  LoginViewModel.swift
//  Shuaa_SwiftUI
//
//  Created by Tawfeeq Irshaidat on 21/07/2025.
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
                    debugPrint("Error evaluating biometrics policy")
                }
            }
        } else {
            completion(.failure(error ?? NSError()))
            debugPrint("Error: No biometrics available")
        }
    }
}

class LoginViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    
    @Published var username: String = ""
    @Published var password: String = ""

    @Published var isRememberMe: Bool = false
    @Published var showAlert: Bool = false
    
    
    @Published var showMessagePopUp:Bool = false
    @Published var loginMessage:String = ""
    

    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
                
        if isRememberMe {
            self.username = KeyChainController().savedUsername ?? ""
            self.password = KeyChainController().savedUserPassword ?? ""
        }
    }
}

// MARK: Routing
extension LoginViewModel {
    
}

// MARK: API Calls
extension LoginViewModel {
    
}

// MARK: Functions
extension LoginViewModel {    
        
    func changeLanguage() {
        AppUtility.shared.updateAppLanguage(language: AppUtility.shared.isRTL ? .english : .arabic)
        SceneDelegate.getAppCoordinator()?.restart()
    }
}
