//
//  GenericRoute.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation

enum GenericRoute:APITargetType{
    
    case GetLookups(requestModel: GetLookupsRequestModel)
    case GetCompaniesLookups(requestModel: GetCompaniesLookupsRequestModel)

    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
                
            default:
                return  NetworkUtility.getHeader(.withoutToken)
                
            }
        }
    }
    
    var path: String{
        switch self {
        case .GetLookups:
            return "GeneralWServices/GetLookups/\(KeyChainController.shared().webCode ?? "")"
        case .GetCompaniesLookups:
            return "GeneralWServices/GetCompaniesLookups/\(KeyChainController().webCode ?? "")"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetLookups, .GetCompaniesLookups:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetLookups, .GetCompaniesLookups:
                .requestPlain
        }
    }
}
