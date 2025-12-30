//
//  SettingViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 28/07/2025.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    private var coordinator: ManageCoordinatorProtocol
    
    @Published var themeToggle: Bool
    @Published var companiesLogoToggle: Bool = true
    @Published var classificationBySectorToggle: Bool = true
    @Published var biometricLoginToggle: Bool = false
    @Published var pinLoginToggle: Bool = false
    
    init(coordinator: ManageCoordinatorProtocol) {
        self.coordinator = coordinator
        
        if AppUtility.shared.isDarkTheme {
            themeToggle = true
        } else {
            themeToggle = false
        }
        
        if UserDefaultController().isCompaniesLogoEnabled == nil {
            UserDefaultController().isCompaniesLogoEnabled = true
        }
        
        if UserDefaultController().isClassificationBySectorEnabled == nil {
            UserDefaultController().isClassificationBySectorEnabled = true
        }
        
        companiesLogoToggle = UserDefaultController().isCompaniesLogoEnabled ?? true
        classificationBySectorToggle = UserDefaultController().isClassificationBySectorEnabled ?? true
        biometricLoginToggle = UserDefaultController().isBiometricEnabled ?? false
        pinLoginToggle = UserDefaultController().isPinEnabled ?? false
    }
}

// MARK: Routing
extension SettingViewModel {
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openSetNewPinScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getAuthCoordinator().openSetNewPinScene(username: KeyChainController().username ?? "", password: KeyChainController().password ?? "")
    }
}

// MARK: Function
extension SettingViewModel {
    func faceId() {
        LocalAuthenticationService.authenticateWithBiometrics { result in
            switch result {
            case .success():
                UserDefaultController().isBiometricEnabled = true
                UserDefaultController().isPinEnabled = false
                self.pinLoginToggle = false
            case .failure(let error):
                UserDefaultController().isBiometricEnabled = false
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, error.localizedDescription)
            }
        }
    }
    
    func onLanguageTap() {
        SceneDelegate.getAppCoordinator()?.restart()
    }
    
    func onDarkThemeToggle(isOn:Bool) {
        UserDefaultController().appTheme = isOn ? .dark : .light
        SceneDelegate.getAppCoordinator()?.updateWindowBackground()
        SceneDelegate.getAppCoordinator()?.restart()
    }
    
    func onCompaniesLogoToggle(isOn:Bool) {
        UserDefaultController().isCompaniesLogoEnabled = isOn
    }
    
    func onClassificationBySector(isOn:Bool) {
        UserDefaultController().isClassificationBySectorEnabled = isOn
    }
    
    func onBiometricLoginToggle(isOn:Bool) {
        if isOn == true && UserDefaultController().isRememberMe == false {
            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "please_enable_remember_me_option_to_use_biometric_login".localized)
            biometricLoginToggle = false
            return
        }

        if (isOn == true && UserDefaultController().isPinEnabled == true) {
            faceId()
        }
        
        
        if isOn == false && UserDefaultController().isPinEnabled == false {
            UserDefaultController().isRememberMe = false
        }
        
        UserDefaultController().isBiometricEnabled = isOn
    }
    
    func onPinLoginToggle(isOn:Bool) {
        if isOn == true && UserDefaultController().isRememberMe == false {
            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "please_enable_remember_me_option_to_use_pin_login".localized)
            pinLoginToggle = false
            return
        }
        
        if (isOn == true && UserDefaultController().isBiometricEnabled == true) {
            openSetNewPinScene()
        }

        if isOn == false && UserDefaultController().isBiometricEnabled == false {
            UserDefaultController().isRememberMe = false
        }
        
        UserDefaultController().isPinEnabled = isOn
    }

}
