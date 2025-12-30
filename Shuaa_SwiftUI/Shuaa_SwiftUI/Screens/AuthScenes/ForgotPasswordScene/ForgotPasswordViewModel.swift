//
//  ForgotPasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation

class ForgotPasswordViewModel:ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private let useCase: LoginUseCaseProtocol

    @Published var forgotType: ForgotDataEnum
    
    @Published var userAuthenticateAdvanceAPIResult:APIResultType<UserAuthenticationAdvanceUIModel>?

    init(coordinator: AuthCoordinatorProtocol, forgotType: ForgotDataEnum, useCase: LoginUseCaseProtocol) {
        self.coordinator = coordinator
        self.forgotType = forgotType
        self.useCase = useCase
    }
}

// MARK: Routing
extension ForgotPasswordViewModel {
    func onBack() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension ForgotPasswordViewModel {
    func callUserAuthenticateAdvanceAPI(success: Bool, nin: String, qID: String) {

        let requestModel = UserAuthenticationAdvanceRequestModel(
            email: "",
            id: qID,
            mobile: "",
            mobileType: "iOS/unrecognized/17.3.1/v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")",
            nin: nin,
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
                        self?.coordinator.openConfirmOtpScene(forgotType: self?.forgotType ?? .forgotPassword, nin: nin, qID: qID, username: success.userName ?? "")
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
