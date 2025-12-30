//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum AuthRoute:APITargetType{
    
    case login(requestModel: LoginRequestModel )
    case OTP(requestModel: OTPRequestModel )
    case GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel)
    case userAuthenticationAdvance(requestModel: UserAuthenticationAdvanceRequestModel)
    case RegistrationsOTP(requestModel: RegistrationsOTPRequestModel)
    case ResetPasswordAdvance(requestModel: ResetPasswordAdvanceRequestModel)

    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
            case .ResetPasswordAdvance:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["Cookie"] = KeyChainController().resetPasswordCookies
                return dicHeader
                default:
                    return  NetworkUtility.getHeader(.withoutToken)
            }
        }
    }

    var path: String{
        switch self {
        case .login:
            return "GeneralWServices/UserAuthintications"
        case .OTP:
           return  "GeneralWServices/RegistrationsOTP"
        case .GetDeviceConfigs:
            return "GeneralWServices/GetDeviceConfigs"
        case .userAuthenticationAdvance:
            return "GeneralWServices/UserAuthinticationAdvance"
        case .RegistrationsOTP:
            return "GeneralWServices/RegistrationsOTP"
        case .ResetPasswordAdvance:
            return "GeneralWServices/ResetPasswordAdvance"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .login, .OTP, .userAuthenticationAdvance, .RegistrationsOTP, .ResetPasswordAdvance:
                return .post
            case .GetDeviceConfigs:
                return .get
            }
        }
    }

    var requestType: APITypeOfRequest{
        switch self {
        case .login( let RequestModel):
                .requestJsonEncodable(RequestModel)
        case .OTP(requestModel: let requestModel):
                .requestJsonEncodable(requestModel)
        case .userAuthenticationAdvance(let requestModel):
                .requestJsonEncodable(requestModel)
        case .RegistrationsOTP(let requestModel):
                .requestJsonEncodable(requestModel)
        case .ResetPasswordAdvance(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetDeviceConfigs:
                .requestPlain
        }
    }}
