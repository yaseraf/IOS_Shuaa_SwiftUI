//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol LoginUseCaseProtocol{
    func loginMap(requestModel: LoginRequestModel , completion: @escaping(Result<LoginUIModel, NetworkError>, [HTTPCookie]?) -> Void) async
    func otp(requestModel: OTPRequestModel , completion: @escaping(Result<otpUIModel, NetworkError>) -> Void) async
    func GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel , completion: @escaping(Result<GetDeviceConfigsUIModel, NetworkError>) -> Void) async
    func userAuthenticationAdvance(requestModel: UserAuthenticationAdvanceRequestModel, completion: @escaping(Result<UserAuthenticationAdvanceUIModel, NetworkError>) -> Void) async
    func RegistrationsOTP(requestModel: RegistrationsOTPRequestModel, completion: @escaping(Result<RegistrationsOTPUIModel, NetworkError>, [HTTPCookie]?) -> Void) async
    func ResetPasswordAdvance(requestModel: ResetPasswordAdvanceRequestModel, completion: @escaping(Result<ResetPasswordAdvanceUIModel, NetworkError>) -> Void) async
}

class LoginUseCase {
    private let repository: AuthRepositoryProtocol
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
}

extension LoginUseCase: LoginUseCaseProtocol {
    func otp(requestModel: OTPRequestModel, completion: @escaping (Result<otpUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.OTP(requestModel: requestModel)
        await repository.OTP(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = otpUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func loginMap(requestModel: LoginRequestModel, completion: @escaping (Result<LoginUIModel, NetworkError>, [HTTPCookie]?) -> Void) async {
        let route = AuthRoute.login(requestModel: requestModel)
        await repository.login(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let cookies = HTTPCookieStorage.shared.cookies(for: route.baseURL)

                let uiModel = LoginUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel), cookies)
                
            case .failure(let failure):
                completion(.failure(failure), [])
            }
        }
    }
    
    func GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel, completion: @escaping (Result<GetDeviceConfigsUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetDeviceConfigs(requestModel: requestModel)
        await repository.GetDeviceConfigs(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = GetDeviceConfigsUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func userAuthenticationAdvance(requestModel: UserAuthenticationAdvanceRequestModel, completion: @escaping (Result<UserAuthenticationAdvanceUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.userAuthenticationAdvance(requestModel: requestModel)
        await repository.userAuthenticationAdvance(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = UserAuthenticationAdvanceUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func RegistrationsOTP(requestModel: RegistrationsOTPRequestModel, completion: @escaping (Result<RegistrationsOTPUIModel, NetworkError>, [HTTPCookie]?) -> Void) async {
        let route = AuthRoute.RegistrationsOTP(requestModel: requestModel)
        await repository.RegistrationsOTP(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let cookies = HTTPCookieStorage.shared.cookies(for: route.baseURL)

                let uiModel = RegistrationsOTPUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel), cookies)

            case .failure(let failure):
                completion(.failure(failure), [])
            }
        }
    }
    
    func ResetPasswordAdvance(requestModel: ResetPasswordAdvanceRequestModel, completion: @escaping (Result<ResetPasswordAdvanceUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.ResetPasswordAdvance(requestModel: requestModel)
        await repository.ResetPasswordAdvance(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ResetPasswordAdvanceUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
