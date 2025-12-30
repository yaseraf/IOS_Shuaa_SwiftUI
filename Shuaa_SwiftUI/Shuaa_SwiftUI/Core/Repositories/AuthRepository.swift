//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol AuthRepositoryProtocol {
    func login(route:AuthRoute, completion: @escaping(Result<LoginResponseModel, NetworkError>) -> Void) async
    func OTP (route:AuthRoute, completion: @escaping(Result<OTPResponseModel, NetworkError>) -> Void) async
    func GetDeviceConfigs (route:AuthRoute, completion: @escaping(Result<GetDeviceConfigsResponseModel, NetworkError>) -> Void) async
    func userAuthenticationAdvance(route: AuthRoute, completion: @escaping(Result<UserAuthenticationAdvanceResponseModel, NetworkError>) -> Void) async
    func RegistrationsOTP(route: AuthRoute, completion: @escaping(Result<RegistrationsOTPResponseModel, NetworkError>) -> Void) async
    func ResetPasswordAdvance(route: AuthRoute, completion: @escaping(Result<ResetPasswordAdvanceResponseModel, NetworkError>) -> Void) async
}

class AuthRepository: AuthRepositoryProtocol {
    func OTP(route: AuthRoute, completion: @escaping (Result<OTPResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: OTPResponseModel.self, completion: completion).requestApi()
    }
    
    func login(route: AuthRoute, completion: @escaping (Result<LoginResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: LoginResponseModel.self, completion: completion).requestApi()
    }
    
    
    func GetDeviceConfigs(route: AuthRoute, completion: @escaping (Result<GetDeviceConfigsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetDeviceConfigsResponseModel.self, completion: completion).requestApi()
    }
    
    func userAuthenticationAdvance(route: AuthRoute, completion: @escaping (Result<UserAuthenticationAdvanceResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: UserAuthenticationAdvanceResponseModel.self, completion: completion).requestApi()
    }

    func RegistrationsOTP(route: AuthRoute, completion: @escaping (Result<RegistrationsOTPResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: RegistrationsOTPResponseModel.self, completion: completion).requestApi()
    }
    
    func ResetPasswordAdvance(route: AuthRoute, completion: @escaping (Result<ResetPasswordAdvanceResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: ResetPasswordAdvanceResponseModel.self, completion: completion).requestApi()
    }
}
